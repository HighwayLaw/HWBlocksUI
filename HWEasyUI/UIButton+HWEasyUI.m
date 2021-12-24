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

#pragma mark - public methods

- (void)setEventsHandler:(HWClickActionBlock)clickHandler forControlEvents:(UIControlEvents)controlEvents {
    NSAssert(clickHandler, @"clickHandler cannot be nil");
    [self configTargetForEvents:controlEvents];
    objc_setAssociatedObject(self, HWEasyUIClickHandlerKey, clickHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - private methods

- (void)configTargetForEvents:(UIControlEvents)events {
    HWEasyUIProxy *target = [HWEasyUIProxy sharedInstance];
    if (![self.allTargets containsObject:target] && !(self.allControlEvents&events)) {
        [self addTarget:target action:@selector(hanldeButtonEvents:) forControlEvents:events];
    }
}

#pragma mark - setters

- (void)setClickHandler:(HWClickActionBlock)clickHandler {
    [self setEventsHandler:clickHandler forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - getters

- (HWClickActionBlock)clickHandler {
    return objc_getAssociatedObject(self, &HWEasyUIClickHandlerKey);
}

@end
