//
//  UIButton+HWBlocksUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import "UIButton+HWBlocksUI.h"
#import "HWBlocksUIProxy.h"
#import "objc/runtime.h"

static void *HWBlocksUIClickHandlerKey = &HWBlocksUIClickHandlerKey;

@implementation UIButton (HWBlocksUI)

#pragma mark - public methods

- (void)setEventsHandler:(HWClickActionBlock)clickHandler forControlEvents:(UIControlEvents)controlEvents {
    NSAssert(clickHandler, @"clickHandler cannot be nil");
    [self configTargetForEvents:controlEvents];
    objc_setAssociatedObject(self, HWBlocksUIClickHandlerKey, clickHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - private methods

- (void)configTargetForEvents:(UIControlEvents)events {
    HWBlocksUIProxy *target = [HWBlocksUIProxy sharedInstance];
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
    return objc_getAssociatedObject(self, &HWBlocksUIClickHandlerKey);
}

@end
