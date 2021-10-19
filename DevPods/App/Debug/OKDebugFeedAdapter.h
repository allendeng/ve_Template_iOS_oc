//
//  OKDebugFeedAdapter.h
//  OKStartUp
//
//  Created by bob on 2020/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKDebugSectionModel;

@interface OKDebugFeedAdapter : NSObject<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithFeeds:(NSArray<OKDebugSectionModel *> *)feeds
                     navigate:(UINavigationController *)navigate;

- (void)registerTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
