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
typedef NSInteger(^HWNumberOfSectionsBlock)(UITableView *tableView);

//UITableViewDelegate
typedef CGFloat(^HWHeightForRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat(^HWHeightForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef CGFloat(^HWHeightForFooterBlock)(UITableView *tableView, NSInteger section);
typedef UIView *_Nonnull(^HWViewForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef UIView *_Nonnull(^HWViewForFooterBlock)(UITableView *tableView, NSInteger section);

typedef void(^HWDidSelectRowBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface UITableView (HWEasyUI)

@property (nonatomic, copy) HWCellForRowBlock cellForRowHandler;
@property (nonatomic, copy) HWNumberOfRowsBlock numberOfRowsHandler;
@property (nonatomic, copy) HWNumberOfSectionsBlock numberOfSectionsHandler;

@property (nonatomic, copy) HWHeightForRowBlock heightForRowHandler;
@property (nonatomic, copy) HWHeightForHeaderBlock heightForHeaderHandler;
@property (nonatomic, copy) HWHeightForFooterBlock heightForFooterHandler;
@property (nonatomic, copy) HWViewForHeaderBlock viewForHeaderHandler;
@property (nonatomic, copy) HWViewForFooterBlock viewForFooterHandler;
@property (nonatomic, copy) HWDidSelectRowBlock didSelectRowHandler;

@end

NS_ASSUME_NONNULL_END
