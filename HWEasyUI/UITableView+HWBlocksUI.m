//
//  UITableView+HWBlocksUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import "UITableView+HWBlocksUI.h"
#import "HWBlocksUIProxy.h"
#import "objc/runtime.h"

static void *HWBlocksUICellForRowHandlerKey = &HWBlocksUICellForRowHandlerKey;
static void *HWBlocksUINumberOfRowsHandlerKey = &HWBlocksUINumberOfRowsHandlerKey;
static void *HWBlocksUINumberOfSectionsHandlerKey = &HWBlocksUINumberOfSectionsHandlerKey;
static void *HWBlocksUIHeightForRowHandlerKey = &HWBlocksUIHeightForRowHandlerKey;
static void *HWBlocksUIHeightForHeaderHandlerKey = &HWBlocksUIHeightForHeaderHandlerKey;
static void *HWBlocksUIHeightForFooterHandlerKey = &HWBlocksUIHeightForFooterHandlerKey;
static void *HWBlocksUIViewForHeaderHandlerKey = &HWBlocksUIViewForHeaderHandlerKey;
static void *HWBlocksUIViewForFooterHandlerKey = &HWBlocksUIViewForFooterHandlerKey;
static void *HWBlocksUIDidSelectRowHandlerKey = &HWBlocksUIDidSelectRowHandlerKey;


@implementation UITableView (HWBlocksUI)

#pragma mark - private methods

- (void)configDelegate {
    HWBlocksUIProxy *delegate = [HWBlocksUIProxy sharedInstance];
    if (self.delegate != delegate) {
        self.delegate = delegate;
    }
}

- (void)configDataSource {
    HWBlocksUIProxy *dataSource = [HWBlocksUIProxy sharedInstance];
    if (self.dataSource != dataSource) {
        self.dataSource = dataSource;
    }
}

#pragma mark - setters

- (void)setCellForRowHandler:(HWCellForRowBlock)cellForRowHandler {
    NSAssert(cellForRowHandler, @"cellForRowHandler cannot be nil");
    [self configDataSource];
    objc_setAssociatedObject(self, HWBlocksUICellForRowHandlerKey, cellForRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNumberOfRowsHandler:(HWNumberOfRowsBlock)numberOfRowsHandler {
    NSAssert(numberOfRowsHandler, @"numberOfRowsHandler cannot be nil");
    [self configDataSource];
    objc_setAssociatedObject(self, HWBlocksUINumberOfRowsHandlerKey, numberOfRowsHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNumberOfSectionsHandler:(HWNumberOfSectionsBlock)numberOfSectionsHandler {
    NSAssert(numberOfSectionsHandler, @"numberOfSectionsHandler cannot be nil");
    [self configDataSource];
    objc_setAssociatedObject(self, HWBlocksUINumberOfSectionsHandlerKey, numberOfSectionsHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForRowHandler:(HWHeightForRowBlock)heightForRowHandler {
    NSAssert(heightForRowHandler, @"heightForRowHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIHeightForRowHandlerKey, heightForRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForHeaderHandler:(HWHeightForHeaderBlock)heightForHeaderHandler {
    NSAssert(heightForHeaderHandler, @"heightForHeaderHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIHeightForHeaderHandlerKey, heightForHeaderHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightForFooterHandler:(HWHeightForFooterBlock)heightForFooterHandler {
    NSAssert(heightForFooterHandler, @"heightForFooterHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIHeightForFooterHandlerKey, heightForFooterHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setViewForHeaderHandler:(HWViewForHeaderBlock)viewForHeaderHandler {
    NSAssert(viewForHeaderHandler, @"viewForHeaderHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIViewForHeaderHandlerKey, viewForHeaderHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setViewForFooterHandler:(HWViewForFooterBlock)viewForFooterHandler {
    NSAssert(viewForFooterHandler, @"viewForFooterHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIViewForHeaderHandlerKey, viewForFooterHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDidSelectRowHandler:(HWDidSelectRowBlock)didSelectRowHandler {
    NSAssert(didSelectRowHandler, @"didSelectRowHandler cannot be nil");
    [self configDelegate];
    objc_setAssociatedObject(self, HWBlocksUIDidSelectRowHandlerKey, didSelectRowHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (HWCellForRowBlock)cellForRowHandler {
    return objc_getAssociatedObject(self, &HWBlocksUICellForRowHandlerKey);
}

- (HWNumberOfRowsBlock)numberOfRowsHandler {
    return objc_getAssociatedObject(self, &HWBlocksUINumberOfRowsHandlerKey);
}

- (HWNumberOfSectionsBlock)numberOfSectionsHandler {
    return objc_getAssociatedObject(self, &HWBlocksUINumberOfSectionsHandlerKey);
}

- (HWHeightForRowBlock)heightForRowHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIHeightForRowHandlerKey);
}

- (HWHeightForHeaderBlock)heightForHeaderHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIHeightForHeaderHandlerKey);
}

- (HWHeightForFooterBlock)heightForFooterHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIHeightForFooterHandlerKey);
}

- (HWViewForHeaderBlock)viewForHeaderHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIViewForHeaderHandlerKey);
}

- (HWViewForFooterBlock)viewForFooterHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIHeightForFooterHandlerKey);
}

- (HWDidSelectRowBlock)didSelectRowHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIDidSelectRowHandlerKey);
}

@end
