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

- (void)handleTouchDown:(id)sender;
- (void)handleTouchDownRepeat:(id)sender;
- (void)handleTouchDragInside:(id)sender;
- (void)handleTouchDragOutside:(id)sender;
- (void)handleTouchDragEnter:(id)sender;
- (void)handleTouchDragExit:(id)sender;
- (void)handleTouchUpInside:(id)sender;
- (void)handleTouchUpOutside:(id)sender;
- (void)handleTouchCancel:(id)sender;

@end

NS_ASSUME_NONNULL_END
