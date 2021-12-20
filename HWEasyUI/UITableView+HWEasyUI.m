//
//  UITableView+HWEasyUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import "UITableView+HWEasyUI.h"
#import "HWEasyUIProxy.h"
#import "objc/runtime.h"

static void *HWEasyUICellForRowHandlerKey = &HWEasyUICellForRowHandlerKey;
static void *HWEasyUINumberOfRowsHandlerKey = &HWEasyUINumberOfRowsHandlerKey;
static void *HWEasyUINumberOfSectionsHandlerKey = &HWEasyUINumberOfSectionsHandlerKey;
static void *HWEasyUIHeightForRowHandlerKey = &HWEasyUIHeightForRowHandlerKey;
static void *HWEasyUIDidSelectRowHandlerKey = &HWEasyUIDidSelectRowHandlerKey;

@implementation UITableView (HWEasyUI)

#pragma mark - private methods

- (void)configDelegate {
    HWEasyUIProxy *delegate = [HWEasyUIProxy sharedInstance];
    if (!self.delegate) {
        self.delegate = delegate;
    }
}

- (void)configDataSource {
    HWEasyUIProxy *dataSource = [HWEasyUIProxy sharedInstance];
    if (!self.dataSource) {
        self.dataSource = dataSource;
    }
}

#pragma mark - setters

- (void)setCellForRowHandler:(HWCellForRowBlock)cellForRowHandler {
    NSAssert(cellForRowHandler, @"cellForRowHandler cannot be nil");
    [self configDataSource];
    objc_setAssociatedObject(self, HWEasyUICellForRowHandlerKey, cellForRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNumberOfRowsHandler:(HWNumberOfRowsBlock)numberOfRowsHandler {
    NSAssert(numberOfRowsHandler, @"numberOfRowsHandler cannot be nil");
    [self configDataSource];
    objc_setAssociatedObject(self, HWEasyUINumberOfRowsHandlerKey, numberOfRowsHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNumberOfSectionsHandler:(HWNumberOfSectionsBlock)numberOfSectionsHandler {
    NSAssert(numberOfSectionsHandler, @"numberOfSectionsHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUINumberOfSectionsHandlerKey, numberOfSectionsHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForRowHandler:(HWHeightForRowBlock)heightForRowHandler {
    NSAssert(heightForRowHandler, @"heightForRowHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIHeightForRowHandlerKey, heightForRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDidSelectRowHandler:(HWDidSelectRowBlock)didSelectRowHandler {
    NSAssert(didSelectRowHandler, @"didSelectRowHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIDidSelectRowHandlerKey, didSelectRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (HWCellForRowBlock)cellForRowHandler {
    return objc_getAssociatedObject(self, &HWEasyUICellForRowHandlerKey);
}

- (HWNumberOfRowsBlock)numberOfRowsHandler {
    return objc_getAssociatedObject(self, &HWEasyUINumberOfRowsHandlerKey);
}

- (HWNumberOfSectionsBlock)numberOfSectionsHandler {
    return objc_getAssociatedObject(self, &HWEasyUINumberOfSectionsHandlerKey);
}

- (HWHeightForRowBlock)heightForRowHandler {
    return objc_getAssociatedObject(self, &HWEasyUIHeightForRowHandlerKey);
}

- (HWDidSelectRowBlock)didSelectRowHandler {
    return objc_getAssociatedObject(self, &HWEasyUIDidSelectRowHandlerKey);
}

@end
