//
//  UITableView+HWEasyUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//UITableViewDataSource
typedef UITableViewCell *_Nonnull(^HWCellForRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSInteger(^HWNumberOfRowsBlock)(UITableView *tableView, NSInteger section);

//UITableViewDelegate
typedef NSInteger(^HWNumberOfSectionsBlock)(UITableView *tableView);
typedef CGFloat(^HWHeightForRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef void(^HWDidSelectRowBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface UITableView (HWEasyUI)

@property (nonatomic, copy) HWCellForRowBlock cellForRowHandler;
@property (nonatomic, copy) HWNumberOfRowsBlock numberOfRowsHandler;
@property (nonatomic, copy) HWNumberOfSectionsBlock numberOfSectionsHandler;
@property (nonatomic, copy) HWHeightForRowBlock heightForRowHandler;
@property (nonatomic, copy) HWDidSelectRowBlock didSelectRowHandler;

@end

NS_ASSUME_NONNULL_END
