//
//  UIButton+HWEasyUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import "UIButton+HWEasyUI.h"
#import "HWEasyUIProxy.h"
#import "objc/runtime.h"

static void *HWEasyUIClickHandlerKey = &HWEasyUIClickHandlerKey;

@implementation UIButton (HWEasyUI)

#pragma mark - private methods

- (void)configTarget {
    HWEasyUIProxy *target = [HWEasyUIProxy sharedInstance];
    if (![self.allTargets containsObject:target]) {
        [self addTarget:target action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - setters

- (void)setClickHandler:(HWClickActionBlock)ClickHandler {
    NSAssert(ClickHandler, @"ClickHandler cannot be nil");
    [self configTarget];
    objc_setAssociatedObject(self, HWEasyUIClickHandlerKey, ClickHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (HWClickActionBlock)clickHandler {
    return objc_getAssociatedObject(self, &HWEasyUIClickHandlerKey);
}

@end
