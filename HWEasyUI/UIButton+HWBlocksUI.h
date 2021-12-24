//
//  UIButton+HWBlocksUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HWClickActionBlock)(void);

@interface UIButton (HWBlocksUI)

//simple method for UIControlEventTouchUpInside
@property (nonatomic, copy) HWClickActionBlock clickHandler;

- (void)setEventsHandler:(HWClickActionBlock _Nonnull)clickHandler forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
