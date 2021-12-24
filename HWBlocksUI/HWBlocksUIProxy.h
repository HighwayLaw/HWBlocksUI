//
//  HWUIDelegate.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWBlocksUIProxy : NSObject <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

+ (instancetype)sharedInstance;

- (void)hanldeButtonEvents:(id)sender;

@end

NS_ASSUME_NONNULL_END
