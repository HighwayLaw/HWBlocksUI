//
//  UITableView+HWEasyUI.h
//  TestApp
//
//  Created by liuhaiwei on 2021/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//UITableViewDataSource
typedef UITableViewCell *_Nonnull(^HWCellForRowBlock)(UITableView *__weak weakTableView, NSIndexPath *indexPath);
typedef NSInteger(^HWNumberOfRowsBlock)(UITableView *__weak weakTableView, NSInteger section);
typedef NSInteger(^HWNumberOfSectionsBlock)(UITableView *__weak weakTableView);

//UITableViewDelegate
typedef CGFloat(^HWHeightForRowBlock)(UITableView *__weak weakTableView, NSIndexPath *indexPath);
typedef CGFloat(^HWHeightForHeaderBlock)(UITableView *__weak weakTableView, NSInteger section);
typedef CGFloat(^HWHeightForFooterBlock)(UITableView *__weak weakTableView, NSInteger section);
typedef UIView *_Nonnull(^HWViewForHeaderBlock)(UITableView *__weak weakTableView, NSInteger section);
typedef UIView *_Nonnull(^HWViewForFooterBlock)(UITableView *__weak weakTableView, NSInteger section);

typedef void(^HWDidSelectRowBlock)(UITableView *__weak weakTableView, NSIndexPath *indexPath);

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
