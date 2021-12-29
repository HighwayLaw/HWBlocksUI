# HWBlocksUI
A set of utilities to make UIKit Easier to write

# 使用
## CocoaPods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'TestApp' do
  pod 'HWBlocksUI', '~>0.0.2'
end

```

# 背景
`UIKit`中的许多常用控件通过`Delegate`方式或者指定`target+selector`来实现事件回调，例如`UITableView`，`UITextField`，`UIButton`等。这种方式的优点是代码规整，在代码量大的时候更容易维护。但是当回调逻辑不是特别复杂时，使用`Block`回调会比`Delegate`或`target+selector`更加有优势，具体体现在：
- **代码紧凑，无需声明协议，可以将相关代码逻辑集中在一起，降低开发调试成本；**
- **允许访问上下文变量，无需再专门抽出实例变量供不同代理方法共享。**

苹果自身也曾经调整过部分`API`，专门支持`Block`回调方式，例如`NSTimer`，在`iOS 10`后新增了方法：
```swift
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats Block:(void (^)(NSTimer *timer))Block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));
```
用来取代之前指定`target+selector`的方法：
```swift
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
```
又例如`iOS 9`之前常用的`UIAlertViewController`，要通过`UIAlertViewDelegate`实现点击回调，苹果干脆废弃重写了一个类`UIAlertController`，抽出`UIAlertAction`类，完全通过`Block`方式实现，代码写起来简洁明了很多：
```swift
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;
```

# 优化思路
鉴于上述分析，对`UITableView`，`UITextField`，`UIButton`等常用的`UIKit`类进行`Block`改写，同时希望做到以下几点：
- **在`Delegate`的基础上增加对应的`Block`方式，原有`Delegate`方式不受影响，调用方可根据实际场景自行选择合适的回调方式；**
- **`Block`的方法与原`Delegate`方法名字尽量保持一致，降低迁移成本；**
- **赋值`Block`回调时，`Xcode`要能自动代码填充，因为手写`Block`入参回参容易出错；**
- **尽量不使用`method swizzling`等黑魔法，对安全性与稳定性的影响降到最小。**

# HWBlocksUI
基于上述目的，笔者封装了[HWBlocksUI](https://github.com/HighwayLaw/HWBlocksUI)库，对`UITableView`，`UITextField`，`UIButton`常用UI组件做了Block改造，使用示例如下：

`UITableView`实现一个简单列表:
```swift
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
    [self.view addSubview:tableView];

    NSArray *titles = @[@"北京", @"上海", @"深圳", @"广州", @"成都", @"雄安", @"苏州"];
    
    tableView.numberOfRowsHandler = ^NSInteger(UITableView *__weak  _Nonnull tableView, NSInteger section) {
        return titles.count;
    };
    
    tableView.cellForRowHandler = ^UITableViewCell * _Nonnull(UITableView *__weak  _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
        cell.textLabel.text = titles[indexPath.row];
        return cell;
    };
    
    tableView.didSelectRowHandler = ^(UITableView *__weak  _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        NSString *title = titles[indexPath.row];
        NSLog(title);
    };
```

`UITextField`实现一个最多允许输入6个字符的输入框：
```swift
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];

    textField.shouldChangeCharactersHandler = ^BOOL(UITextField *__weak  _Nonnull textField, NSRange range, NSString * _Nonnull replacementString) {
        NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
        if (str.length > 6) {
            return NO;
        }
        return YES;
    };

    textField.shouldReturnHandler = ^BOOL(UITextField *__weak  _Nonnull textField) {
        [textField resignFirstResponder];
        return YES;
    };
```

`UIButton`，考虑到对`UIControlEventsTouchUpInside`事件响应最多，所以专门封了一个`clickHandler`，对其他事件响应可以使用`setHandler:forControlEvents:`：
```swift
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(24, 200, self.view.frame.size.width - 48, 20)];
    [btn setTitle:@"OK" forState:UIControlStateNormal];
    btn.clickHandler = ^{
        NSLog(@"OK");
    };
    [self.view addSubview:btn];
```
# 实现原理

对`UIKit`进行`Block`改造的核心点在于：
- 为要改造的`UIKit`类，添加每个Delegate方法对应的`Block`属性；
- 由于无法改造`UIKit`源码，所以仍然需要有一个`Delegate`对象，实现对应的代理方法；
- `Delegate`对象在执行代理方法时，找到对应的`Block`执行实际回调方法；
- 对调用方隐藏这个`Delegate`对象；

下面以`UITextField`为例看下改造的主要过程：

## 添加Block属性
定义相应`Category`：`UITextField+HWBlocksUI`用来绑定`Block`；梳理`UITextFieldDelegate`的方法，定义对应的`Block`，`Block`属性名采用`Delegate`的方法主体名+`Handler`的形式，入参和回参与`Delegate`方法保持一致，通过`runtime`将该`Block`属性添加到该分类。示例代码如下：

头文件中定义`Block`属性：
```swift
typedef BOOL(^HWShouldBeginEditingBlock)(UITextField *__weak textField);
@property (nonatomic, copy) HWShouldBeginEditingBlock shouldBeginEditingHandler;
```

实现文件中，实现其对应的`setter`和`getter`：
```swift
- (void)setShouldBeginEditingHandler:(HWShouldBeginEditingBlock)shouldBeginEditingHandler {
    NSAssert(shouldBeginEditingHandler, @"shouldBeginEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIShouldBeginEditingKey, shouldBeginEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HWShouldBeginEditingBlock)shouldBeginEditingHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIShouldBeginEditingKey);
}

```
这里`setter`中会同时执行`[self configDelegate]`，接下来会讲到其目的。

## 配置Delegte
新增一个类`HWBlocksUIProxy`，遵循`UITextFieldDelegate`，在其代理方法中，实际执行的是该对象绑定的`Block`，如果没有找到对应的`Block`，则返回默认值：
```swift
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.shouldBeginEditingHandler) {
        return textField.shouldBeginEditingHandler(textField);
    }
    return YES;
}
```
在上步设置`Block`属性时，会把`Delegate`设置为该`HWBlocksUIProxy`：
```swift
- (void)configDelegate {
    HWBlocksUIProxy *Delegate = [HWBlocksUIProxy sharedInstance];
    if (self.Delegate != Delegate) {
        self.Delegate = Delegate;
    }
}
```

## 对调用方隐藏Delegate
由于在每一次设置`Block`时，都会去检查设置`Delegate`，所以达到了对调用方隐藏`Delegate`的目的。考虑到`HWBlocksUIProxy`的使用特征和频率，同时由于其不包含实例变量，只用来转发方法，资源占用很小，方便起见设为单例形式。

## 内存处理

```swift
typedef BOOL(^HWShouldChangeCharactersBlock)(UITextField *__weak textField, NSRange range, NSString *replacementString);
```
定义`Block`时，`UIKit`对象自身需要设置为`__weak`属性，以防出现`UIKit`对象与其持有`Block`之间的循环应用。

# 总结

[HWBlocksUI](https://github.com/HighwayLaw/HWBlocksUI)的实现大部分是胶水代码，不过如果能让调用方更方便使用，维护代价更小，那这一切都是值得做的。欢迎各位大佬一起讨论、使用、改进。



