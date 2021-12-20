//
//  HWUIDelegate.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import <UIKit/UIKit.h>
#import "HWEasyUIProxy.h"
#import "UITableView+HWFastUI.h"

@interface HWEasyUIProxy ()

@end

@implementation HWEasyUIProxy

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSAssert(tableView.cellForRowHandler, @"cellForRowHandler cannot be nil");
    return tableView.cellForRowHandler(tableView, indexPath);
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSAssert(tableView.numberOfRowsHandler, @"numberOfRowsHandler cannot be nil");
    return tableView.numberOfRowsHandler(tableView, section);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.numberOfSectionsHandler) {
        return tableView.numberOfSectionsHandler(tableView);
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.heightForRowHandler) {
        return tableView.heightForRowHandler(tableView, indexPath);
    }
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.didSelectRowHandler) {
        tableView.didSelectRowHandler(tableView, indexPath);
    }
}

@end
