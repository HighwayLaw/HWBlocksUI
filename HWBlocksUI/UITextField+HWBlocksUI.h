//
//  UITextField+HWBlocksUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^HWShouldBeginEditingBlock)(UITextField *__weak textField);
typedef void(^HWDidBeginEditingBlock)(UITextField *__weak textField);
typedef BOOL(^HWShouldEndEditingBlock)(UITextField *__weak textField);
typedef void(^HWDidEndEditingBlock)(UITextField *__weak textField);
typedef BOOL(^HWShouldChangeCharactersBlock)(UITextField *__weak textField, NSRange range, NSString *replacementString);
typedef BOOL(^HWShouldClearBlock)(UITextField *__weak textField);
typedef BOOL(^HWShouldReturnBlock)(UITextField *__weak textField);

@interface UITextField (HWBlocksUI)

@property (nonatomic, copy) HWShouldBeginEditingBlock shouldBeginEditingHandler;
@property (nonatomic, copy) HWDidBeginEditingBlock didBeginEditingHandler;
@property (nonatomic, copy) HWShouldEndEditingBlock shouldEndEditingHandler;
@property (nonatomic, copy) HWDidEndEditingBlock didEndEditingHandler;
@property (nonatomic, copy) HWShouldChangeCharactersBlock shouldChangeCharactersHandler;
@property (nonatomic, copy) HWShouldClearBlock shouldClearHandler;
@property (nonatomic, copy) HWShouldReturnBlock shouldReturnHandler;

@end

NS_ASSUME_NONNULL_END
