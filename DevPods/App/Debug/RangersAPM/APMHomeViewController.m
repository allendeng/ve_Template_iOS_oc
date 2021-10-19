//
//  ViewController.m
//  RangersAPM_iOS
//
//  Created by xuminghao.eric on 2020/11/12.
//

#import "APMHomeViewController.h"
#import "RangersAPMCellItem.h"

#if defined __has_include
# if __has_include("RangersAPMCrashViewController.h")
#import "RangersAPMCrashViewController.h"
# endif
# if __has_include("RangersAPMWatchDogViewController.h")
#import "RangersAPMWatchDogViewController.h"
# endif
# if __has_include("RangersAPMOOMViewController.h")
#import "RangersAPMOOMViewController.h"
# endif
# if __has_include("RangersAPMExceptionViewController.h")
#import "RangersAPMExceptionViewController.h"
# endif
# if __has_include("RangersAPMLagViewController.h")
#import "RangersAPMLagViewController.h"
# endif
# if __has_include("RangersAPMPerformanceViewController.h")
#import "RangersAPMPerformanceViewController.h"
# endif
# if __has_include("RangersAPMHybridViewController.h")
#import "RangersAPMHybridViewController.h"
#endif
# if __has_include("RangersAPMUITrackersViewController.h")
#import "RangersAPMUITrackersViewController.h"
# endif
# if __has_include("RangersAPMMemoryViewController.h")
#import "RangersAPMMemoryViewController.h"
# endif
# if __has_include("RangersAPMNetworkViewController.h")
#import "RangersAPMNetworkViewController.h"
# endif
# if __has_include("RangersAPMEventViewController.h")
#import "RangersAPMEventViewController.h"
# endif
#endif
@interface APMHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *items;

@end

@implementation APMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"RangersAPMCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    self.title = @"RangersAPM";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark Lazy-load
- (NSArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
        __weak typeof(self) weakSelf = self;
        
#if defined __has_include
# if __has_include("RangersAPMCrashViewController.h")
        void(^crashBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMCrashViewController *viewController = [[RangersAPMCrashViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *crashItem = [RangersAPMCellItem itemWithTitle:@"崩溃分析" block:crashBlock];
        [_items addObject:crashItem];
# endif
# if __has_include("RangersAPMWatchDogViewController.h")
        void(^watchBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMCrashViewController *viewController = [[RangersAPMCrashViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *watchItem = [RangersAPMCellItem itemWithTitle:@"崩溃分析" block:watchBlock];
        [_items addObject:watchItem];
# endif
# if __has_include("RangersAPMOOMViewController.h")
        void(^oomBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMCrashViewController *viewController = [[RangersAPMCrashViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *oomItem = [RangersAPMCellItem itemWithTitle:@"崩溃分析" block:oomBlock];
        [_items addObject:oomItem];
# endif
# if __has_include("RangersAPMExceptionViewController.h")
        void(^exceptionBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMExceptionViewController *viewController = [[RangersAPMExceptionViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *exceptionItem = [RangersAPMCellItem itemWithTitle:@"自定义错误" block:exceptionBlock];
        [_items addObject:exceptionItem];
# endif
# if __has_include("RangersAPMLagViewController.h")
        void(^lagBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMLagViewController *viewController = [[RangersAPMLagViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *lagItem = [RangersAPMCellItem itemWithTitle:@"卡顿分析" block:lagBlock];
        [_items addObject:lagItem];
# endif
# if __has_include("RangersAPMEventViewController.h")
        void(^eventBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMEventViewController *viewController = [[RangersAPMEventViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *eventItem = [RangersAPMCellItem itemWithTitle:@"事件分析" block:eventBlock];
        [_items addObject:eventItem];
# endif
# if __has_include("RangersAPMPerformanceViewController.h")
        void(^performanceBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMPerformanceViewController *viewController = [[RangersAPMPerformanceViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *performanceItem = [RangersAPMCellItem itemWithTitle:@"用户体验" block:performanceBlock];
        [_items addObject:performanceItem];
# endif
# if __has_include("RangersAPMHybridViewController.h")
        void(^hybridBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMHybridViewController *viewController = [[RangersAPMHybridViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *hybridItem = [RangersAPMCellItem itemWithTitle:@"页面监控" block:hybridBlock];
        [_items addObject:hybridItem];
#endif
# if __has_include("RangersAPMUITrackersViewController.h")
        void(^trackerBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMHybridViewController *viewController = [[RangersAPMHybridViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *trackerItem = [RangersAPMCellItem itemWithTitle:@"页面响应" block:trackerBlock];
        [_items addObject:trackerItem];
# endif
# if __has_include("RangersAPMMemoryViewController.h")
        
        void(^memoryBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMMemoryViewController *viewController = [[RangersAPMMemoryViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *memoryItem = [RangersAPMCellItem itemWithTitle:@"内存优化" block:memoryBlock];
        [_items addObject:memoryItem];
# endif
# if __has_include("RangersAPMNetworkViewController.h")
        void(^networkBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    RangersAPMNetworkViewController *viewController = [[RangersAPMNetworkViewController alloc] init];
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                }
            });
        };
        RangersAPMCellItem *networkItem = [RangersAPMCellItem itemWithTitle:@"网络分析" block:networkBlock];
        [_items addObject:networkItem];
# endif
#endif
        

    }
    
    return _items;
}

#pragma mark UITableViewDelegate, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RangersAPMCell"];
    RangersAPMCellItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",item.title];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RangersAPMCellItem *item = [self.items objectAtIndex:indexPath.row];
    if (item.selectBlock) {
        item.selectBlock();
    } 
}

@end
