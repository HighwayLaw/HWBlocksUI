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
static void *HWEasyUIHeightForHeaderHandlerKey = &HWEasyUIHeightForHeaderHandlerKey;
static void *HWEasyUIHeightForFooterHandlerKey = &HWEasyUIHeightForFooterHandlerKey;
static void *HWEasyUIViewForHeaderHandlerKey = &HWEasyUIViewForHeaderHandlerKey;
static void *HWEasyUIViewForFooterHandlerKey = &HWEasyUIViewForFooterHandlerKey;
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
    [self configDataSource];
    objc_setAssociatedObject(self, HWEasyUINumberOfSectionsHandlerKey, numberOfSectionsHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForRowHandler:(HWHeightForRowBlock)heightForRowHandler {
    NSAssert(heightForRowHandler, @"heightForRowHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIHeightForRowHandlerKey, heightForRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForHeaderHandler:(HWHeightForHeaderBlock)heightForHeaderHandler {
    NSAssert(heightForHeaderHandler, @"heightForHeaderHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIHeightForHeaderHandlerKey, heightForHeaderHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForFooterHandler:(HWHeightForFooterBlock)heightForFooterHandler {
    NSAssert(heightForFooterHandler, @"heightForFooterHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIHeightForFooterHandlerKey, heightForFooterHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setViewForHeaderHandler:(HWViewForHeaderBlock)viewForHeaderHandler {
    NSAssert(viewForHeaderHandler, @"viewForHeaderHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIViewForHeaderHandlerKey, viewForHeaderHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setViewForFooterHandler:(HWViewForFooterBlock)viewForFooterHandler {
    NSAssert(viewForFooterHandler, @"viewForFooterHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWEasyUIViewForHeaderHandlerKey, viewForFooterHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (HWHeightForHeaderBlock)heightForHeaderHandler {
    return objc_getAssociatedObject(self, &HWEasyUIHeightForHeaderHandlerKey);
}

- (HWHeightForFooterBlock)heightForFooterHandler {
    return objc_getAssociatedObject(self, &HWEasyUIHeightForFooterHandlerKey);
}

- (HWViewForHeaderBlock)viewForHeaderHandler {
    return objc_getAssociatedObject(self, &HWEasyUIViewForHeaderHandlerKey);
}

- (HWViewForFooterBlock)viewForFooterHandler {
    return objc_getAssociatedObject(self, &HWEasyUIHeightForFooterHandlerKey);
}

- (HWDidSelectRowBlock)didSelectRowHandler {
    return objc_getAssociatedObject(self, &HWEasyUIDidSelectRowHandlerKey);
}

@end
