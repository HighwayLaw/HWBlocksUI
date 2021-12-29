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

#pragma mark - private methods

#pragma mark - setters

- (void)setClickHandler:(HWControlEventsActionBlock)clickHandler {
    NSAssert(clickHandler, @"clickHandler cannot be nil");
    objc_setAssociatedObject(self, HWBlocksUIClickHandlerKey, clickHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setHandler:clickHandler forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - getters

- (HWControlEventsActionBlock)clickHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIClickHandlerKey);
}

@end
