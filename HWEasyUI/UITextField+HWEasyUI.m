//
//  UITextField+HWEasyUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import "UITextField+HWEasyUI.h"
#import "HWEasyUIProxy.h"
#import "objc/runtime.h"

static void *HWEasyUIShouldBeginEditingKey = &HWEasyUIShouldBeginEditingKey;
static void *HWEasyUIDidBeginEditingKey = &HWEasyUIDidBeginEditingKey;
static void *HWEasyUIShouldEndEditingKey = &HWEasyUIShouldEndEditingKey;
static void *HWEasyUIDidEndEditingKey = &HWEasyUIDidEndEditingKey;
static void *HWEasyUIShouldChangeCharactersKey = &HWEasyUIShouldChangeCharactersKey;
static void *HWEasyUIShouldClearKey = &HWEasyUIShouldClearKey;
static void *HWEasyUIShouldReturnKey = &HWEasyUIShouldReturnKey;

@implementation UITextField (HWEasyUI)

#pragma mark - private methods

- (void)configDelegate {
    HWEasyUIProxy *delegate = [HWEasyUIProxy sharedInstance];
    if (self.delegate != delegate) {
        self.delegate = delegate;
    }
}

#pragma mark - setters

- (void)setShouldBeginEditingHandler:(HWShouldBeginEditingBlock)shouldBeginEditingHandler {
    NSAssert(shouldBeginEditingHandler, @"shouldBeginEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIShouldBeginEditingKey, shouldBeginEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDidBeginEditingHandler:(HWDidBeginEditingBlock)didBeginEditingHandler {
    NSAssert(didBeginEditingHandler, @"didBeginEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIDidBeginEditingKey, didBeginEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldEndEditingHandler:(HWShouldEndEditingBlock)shouldEndEditingHandler {
    NSAssert(shouldEndEditingHandler, @"shouldEndEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIShouldEndEditingKey, shouldEndEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDidEndEditingHandler:(HWDidEndEditingBlock)didEndEditingHandler {
    NSAssert(didEndEditingHandler, @"didEndEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIDidEndEditingKey, didEndEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldChangeCharactersHandler:(HWShouldChangeCharactersBlock)shouldChangeCharactersHandler {
    NSAssert(shouldChangeCharactersHandler, @"shouldChangeCharactersHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIShouldChangeCharactersKey, shouldChangeCharactersHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldClearHandler:(HWShouldClearBlock)shouldClearHandler {
    NSAssert(shouldClearHandler, @"shouldClearHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIShouldClearKey, shouldClearHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldReturnHandler:(HWShouldReturnBlock)shouldReturnHandler {
    NSAssert(shouldReturnHandler, @"shouldReturnHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIShouldReturnKey, shouldReturnHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (HWShouldBeginEditingBlock)shouldBeginEditingHandler {
    return objc_getAssociatedObject(self, &HWEasyUIShouldBeginEditingKey);
}

- (HWDidBeginEditingBlock)didBeginEditingHandler {
    return objc_getAssociatedObject(self, &HWEasyUIDidBeginEditingKey);
}

- (HWShouldEndEditingBlock)shouldEndEditingHandler {
    return objc_getAssociatedObject(self, &HWEasyUIShouldEndEditingKey);
}

- (HWDidEndEditingBlock)didEndEditingHandler {
    return objc_getAssociatedObject(self, &HWEasyUIDidEndEditingKey);
}

- (HWShouldChangeCharactersBlock)shouldChangeCharactersHandler {
    return objc_getAssociatedObject(self, &HWEasyUIShouldChangeCharactersKey);
}

- (HWShouldClearBlock)shouldClearHandler {
    return objc_getAssociatedObject(self, &HWEasyUIShouldClearKey);
}

- (HWShouldReturnBlock)shouldReturnHandler {
    return objc_getAssociatedObject(self, &HWEasyUIShouldReturnKey);
}

@end
