//
//  UIControl+HWBlocksUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HWControlEventsActionBlock)(void);

@interface UIControl (HWBlocksUI)

- (void)setHandler:(HWControlEventsActionBlock _Nonnull)eventsHandler forControlEvents:(UIControlEvents)controlEvents;
- (HWControlEventsActionBlock)handlerForControlEvent:(UIControlEvents)controlEvent;

@end

NS_ASSUME_NONNULL_END
