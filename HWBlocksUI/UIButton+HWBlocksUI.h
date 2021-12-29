//
//  UIButton+HWBlocksUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import <UIKit/UIKit.h>
#import "UIControl+HWBlocksUI.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HWControlEventsActionBlock)(void);

@interface UIButton (HWBlocksUI)

//simple method for UIControlEventTouchUpInside
@property (nonatomic, copy) HWControlEventsActionBlock clickHandler;

@end

NS_ASSUME_NONNULL_END
