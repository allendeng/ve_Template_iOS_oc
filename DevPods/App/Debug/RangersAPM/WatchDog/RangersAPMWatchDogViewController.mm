//
//  RangersAPMWatchDogViewController.m
//  RangersAPM_iOS
//
//  Created by xuminghao.eric on 2020/11/12.
//

#import "RangersAPMWatchDogViewController.h"
#import "RangersAPMCellItem.h"

@interface RangersAPMWatchDogViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *items;

@end

@implementation RangersAPMWatchDogViewController

#pragma mark - Test cases

- (void)watchdogExceptionTrigger {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (TARGET_IPHONE_SIMULATOR) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不支持的设备" message:@"WatchDog无法在模拟器触发，请使用真机进行测试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        } else if (TARGET_OS_IPHONE) {
            UIAlertController *alert = [self alertWithTitle:@"WatchDog" message:@"即将触发WatchDog，APP将卡住一段时间后闪退，稍后重新启动APP即可在平台上看到崩溃日志" okHandler:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    dispatch_queue_t testWatchDogQueue = dispatch_queue_create("com.RangersAPM.testwatchdog", 0);
                    dispatch_async(testWatchDogQueue, ^{
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            dispatch_sync(testWatchDogQueue, ^{
                                
                            });
                        });
                    });
                });
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"RangersAPMWatchDogCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    self.title = @"WatchDog";
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RangersAPMWatchDogCell"];
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

#pragma mark Lazy-load
- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
        __weak typeof(self) weakSelf = self;
        
        void(^watchDogBlock)(void) = ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf watchdogExceptionTrigger];
            }
        };
        RangersAPMCellItem *watchDogItem = [RangersAPMCellItem itemWithTitle:@"触发卡死" block:watchDogBlock];
        
        [_items addObject:watchDogItem];
    }
    
    return _items;
}

#pragma mark - Tools

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message okHandler:(void (^)(void))okHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okHandler();
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    return alert;
}

@end
