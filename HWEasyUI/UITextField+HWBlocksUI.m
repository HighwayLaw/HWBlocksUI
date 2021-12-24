//
//  UITextField+HWBlocksUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import "UITextField+HWBlocksUI.h"
#import "HWBlocksUIProxy.h"
#import "objc/runtime.h"

static void *HWBlocksUIShouldBeginEditingKey = &HWBlocksUIShouldBeginEditingKey;
static void *HWBlocksUIDidBeginEditingKey = &HWBlocksUIDidBeginEditingKey;
static void *HWBlocksUIShouldEndEditingKey = &HWBlocksUIShouldEndEditingKey;
static void *HWBlocksUIDidEndEditingKey = &HWBlocksUIDidEndEditingKey;
static void *HWBlocksUIShouldChangeCharactersKey = &HWBlocksUIShouldChangeCharactersKey;
static void *HWBlocksUIShouldClearKey = &HWBlocksUIShouldClearKey;
static void *HWBlocksUIShouldReturnKey = &HWBlocksUIShouldReturnKey;

@implementation UITextField (HWBlocksUI)

#pragma mark - private methods

- (void)configDelegate {
    HWBlocksUIProxy *delegate = [HWBlocksUIProxy sharedInstance];
    if (self.delegate != delegate) {
        self.delegate = delegate;
    }
}

#pragma mark - setters

- (void)setShouldBeginEditingHandler:(HWShouldBeginEditingBlock)shouldBeginEditingHandler {
    NSAssert(shouldBeginEditingHandler, @"shouldBeginEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIShouldBeginEditingKey, shouldBeginEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDidBeginEditingHandler:(HWDidBeginEditingBlock)didBeginEditingHandler {
    NSAssert(didBeginEditingHandler, @"didBeginEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIDidBeginEditingKey, didBeginEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldEndEditingHandler:(HWShouldEndEditingBlock)shouldEndEditingHandler {
    NSAssert(shouldEndEditingHandler, @"shouldEndEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIShouldEndEditingKey, shouldEndEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDidEndEditingHandler:(HWDidEndEditingBlock)didEndEditingHandler {
    NSAssert(didEndEditingHandler, @"didEndEditingHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIDidEndEditingKey, didEndEditingHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldChangeCharactersHandler:(HWShouldChangeCharactersBlock)shouldChangeCharactersHandler {
    NSAssert(shouldChangeCharactersHandler, @"shouldChangeCharactersHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIShouldChangeCharactersKey, shouldChangeCharactersHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldClearHandler:(HWShouldClearBlock)shouldClearHandler {
    NSAssert(shouldClearHandler, @"shouldClearHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIShouldClearKey, shouldClearHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldReturnHandler:(HWShouldReturnBlock)shouldReturnHandler {
    NSAssert(shouldReturnHandler, @"shouldReturnHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIShouldReturnKey, shouldReturnHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (HWShouldBeginEditingBlock)shouldBeginEditingHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIShouldBeginEditingKey);
}

- (HWDidBeginEditingBlock)didBeginEditingHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIDidBeginEditingKey);
}

- (HWShouldEndEditingBlock)shouldEndEditingHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIShouldEndEditingKey);
}

- (HWDidEndEditingBlock)didEndEditingHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIDidEndEditingKey);
}

- (HWShouldChangeCharactersBlock)shouldChangeCharactersHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIShouldChangeCharactersKey);
}

- (HWShouldClearBlock)shouldClearHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIShouldClearKey);
}

- (HWShouldReturnBlock)shouldReturnHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIShouldReturnKey);
}

@end
