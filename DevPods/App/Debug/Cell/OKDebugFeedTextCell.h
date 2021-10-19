//
//  OKDebugFeedTextCell.h
//  OKStartUp
//
//  Created by bob on 2020/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKDebugFeedModel;

@interface OKDebugFeedTextCell : UITableViewCell

@property (nonatomic, strong) OKDebugFeedModel *model;

- (void)updateWithModel:(OKDebugFeedModel *)model;

+ (NSString *)feedCellReuseIdentifier;

@end

NS_ASSUME_NONNULL_END
