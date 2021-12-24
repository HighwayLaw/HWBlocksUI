//
//  HWUIDelegate.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import <UIKit/UIKit.h>
#import "HWBlocksUIProxy.h"
#import "UITableView+HWBlocksUI.h"
#import "UIButton+HWBlocksUI.h"
#import "UITextField+HWBlocksUI.h"

@interface HWBlocksUIProxy ()

@end

@implementation HWBlocksUIProxy

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - UIButton

- (void)hanldeButtonEvents:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        if (button.clickHandler) {
            button.clickHandler();
        }
    }
}

#pragma mark - UITableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //required protocol methods
    NSAssert(tableView.cellForRowHandler, @"cellForRowHandler cannot be nil");
    return tableView.cellForRowHandler(tableView, indexPath);
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //required protocol methods
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.heightForHeaderHandler) {
        return tableView.heightForHeaderHandler(tableView, section);
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.heightForFooterHandler) {
        return tableView.heightForFooterHandler(tableView, section);
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.viewForHeaderHandler) {
        return tableView.viewForHeaderHandler(tableView, section);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView.viewForFooterHandler) {
        return tableView.viewForFooterHandler(tableView, section);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.didSelectRowHandler) {
        tableView.didSelectRowHandler(tableView, indexPath);
    }
}

#pragma mark - UITextField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.shouldBeginEditingHandler) {
        return textField.shouldBeginEditingHandler(textField);
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.didBeginEditingHandler) {
        textField.didBeginEditingHandler(textField);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.shouldEndEditingHandler) {
        return textField.shouldEndEditingHandler(textField);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.didEndEditingHandler) {
        textField.didEndEditingHandler(textField);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.shouldChangeCharactersHandler) {
        return textField.shouldChangeCharactersHandler(textField, range, string);
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField.shouldClearHandler) {
        return textField.shouldClearHandler(textField);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.shouldReturnHandler) {
        return textField.shouldReturnHandler(textField);
    }
    return YES;
}

@end
