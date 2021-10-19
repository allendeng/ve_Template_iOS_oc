//
//  RangersAPMUITrackersViewController.m
//  RangersAPM_iOS
//
//  Created by xuminghao.eric on 2020/11/12.
//

#import "RangersAPMUITrackersViewController.h"
#import "RangersAPMCellItem.h"

@interface RangersAPMUITrackersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *items;

@end

@implementation RangersAPMUITrackersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"RangersAPMUITrackersCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.title = @"UITrackers";
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RangersAPMUITrackersCell"];
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
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
        
        __weak typeof(self) weakSelf = self;
        void(^pageLoadBlock)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"页面响应" message:@"页面响应日志在页面切换时自动记录，可以尝试在不同的ViewController之间切换来产生日志" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:ok];
                    [strongSelf presentViewController:alert animated:YES completion:nil];
                }
            });
        };
        RangersAPMCellItem *pageLoadItem = [RangersAPMCellItem itemWithTitle:@"页面响应" block:pageLoadBlock];
        
    
        [_items addObject:pageLoadItem];
    }
    return _items;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
