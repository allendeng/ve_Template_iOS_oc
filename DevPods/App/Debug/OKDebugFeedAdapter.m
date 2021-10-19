//
//  OKDebugFeedAdapter.m
//  OKStartUp
//
//  Created by bob on 2020/4/22.
//

#import "OKDebugFeedAdapter.h"
#import "OKDebugFeedModel.h"
#import "OKDebugFeedTextCell.h"
#import "OKDebugFeedInputCell.h"
#import "OKDebugFeedSwitchCell.h"
#import "OKDebugToast.h"

@interface OKDebugFeedAdapter ()

@property (nonatomic, strong) NSArray<OKDebugSectionModel *> *feeds;
@property (nonatomic, strong) UINavigationController *navigate;

@end

@implementation OKDebugFeedAdapter

- (instancetype)initWithFeeds:(NSArray<OKDebugSectionModel *> *)feeds
                     navigate:(UINavigationController *)navigate {
    self = [super init];
    if (self) {
        self.feeds = feeds;
        self.navigate = navigate;
    }
    
    return self;
}

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[OKDebugFeedSwitchCell class]
      forCellReuseIdentifier:[OKDebugFeedSwitchCell feedCellReuseIdentifier]];
    [tableView registerClass:[OKDebugFeedInputCell class]
      forCellReuseIdentifier:[OKDebugFeedInputCell feedCellReuseIdentifier]];
    [tableView registerClass:[OKDebugFeedTextCell class]
      forCellReuseIdentifier:[OKDebugFeedTextCell feedCellReuseIdentifier]];
}

- (OKDebugFeedModel *)modelForRowAtIndexPath:(NSIndexPath *)indexPath {
    OKDebugSectionModel *section = [self.feeds objectAtIndex:indexPath.section];
    
    return [section.feeds objectAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feeds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OKDebugSectionModel *model = [self.feeds objectAtIndex:section];
    
    return model.feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OKDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    model.index = indexPath.row + 1;
    NSString *cellReuseIdentifier = nil;
    switch (model.feedType) {
        case OKDebugFeedModelTypeText:
            cellReuseIdentifier = [OKDebugFeedTextCell feedCellReuseIdentifier];
            break;
        case OKDebugFeedModelTypeSwitch:
            cellReuseIdentifier = [OKDebugFeedSwitchCell feedCellReuseIdentifier];
            break;
        case OKDebugFeedModelTypeInput:
            cellReuseIdentifier = [OKDebugFeedInputCell feedCellReuseIdentifier];
            break;
    }
    
    OKDebugFeedTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    [cell updateWithModel:model];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    OKDebugSectionModel *model = [self.feeds objectAtIndex:section];
    
    return model.title;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    OKDebugSectionModel *model = [self.feeds objectAtIndex:section];
    
    return [model height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OKDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    OKDebugSectionModel *model = [self.feeds objectAtIndex:section];
    
    return [model height];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OKDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    
    return model.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OKDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    OKDebugFeedNavigateBlock navigateBlock = model.navigateBlock;
    if (model.showToast) {
        [tableView bds_toastShow:@"点击成功，请稍后"];
    }
    if (navigateBlock) {
        navigateBlock(model, self.navigate);
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}


@end
