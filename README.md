# HWBlocksUI
`HWBlocksUI`对`UITableView`，`UITextField`，`UIButton`，`UISwitch`等常用的`UIKit`类进行了扩展，将之前需要`Delegate`或`target+selector`回调的方式改成了`Block`。大部分情况下，使用`Block`更加有优势，具体体现在：

（1）代码紧凑，无需声明协议，可以将相关代码逻辑集中在一起，降低开发调试成本；

（2）允许访问上下文变量，无需再专门抽出实例变量供不同代理方法共享。

更详细的讨论请参考文章 [让UIKit更优雅易用：Block回调改造](https://juejin.cn/post/7045133536495403015)

# 安装
## CocoaPods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'TestApp' do
  pod 'HWBlocksUI', '~>0.0.2'
end

```

# 使用

## **`UITableView`** 
实现一个简单列表：
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

## **`UITextField`** 
实现一个最多允许输入6个字符的输入框：
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

## **`UIButton`**
考虑到对`UIControlEventsTouchUpInside`事件响应最多，所以专门封了一个`clickHandler`，对其他事件响应可以使用`setHandler:forControlEvents:`：
```swift
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(24, 200, self.view.frame.size.width - 48, 20)];
    [btn setTitle:@"OK" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    btn.clickHandler = ^{
        NSLog(@"OK");
    };
    [btn setHandler:^{
            NSLog(@"touch down");
    } forControlEvents:UIControlEventTouchDown];
```
## **`UISwitch`**
所有继承于`UIControl`的类均可支持：
```swift
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
    aSwitch.on = YES;
    [self.view addSubview:aSwitch];
    
    [aSwitch setHandler:^{
        NSLog(@"switch value changed");
    } forControlEvents:UIControlEventValueChanged];
```


