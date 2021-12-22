//
//  UIButton+HWEasyUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HWClickActionBlock)(void);

@interface UIButton (HWEasyUI)

@property (nonatomic, copy) HWClickActionBlock clickHandler;

@end

NS_ASSUME_NONNULL_END
