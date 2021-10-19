//
//  RangersAPMHybridViewController.m
//  RangersAPM_iOS
//
//  Created by xuminghao.eric on 2020/11/12.
//

#import "RangersAPMHybridViewController.h"
#import "RangersAPMCellItem.h"
#import "RangersAPMWebViewController.h"

static NSString *const kUserWebViewPlaceholder = @"请输入完整的URL";

@interface RangersAPMHybridViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *items;

@end

@implementation RangersAPMHybridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"RangersAPMHybridCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    self.title = @"页面监控";
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RangersAPMHybridCell"];
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
        
        void(^normalWebViewBlock)(void) = ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                RangersAPMWebViewController *webViewController = [RangersAPMWebViewController webViewControllerWithURLString:@"https://www.volcengine.cn" title:@"火山引擎"];
                [strongSelf.navigationController pushViewController:webViewController animated:YES];
            }
        };
        RangersAPMCellItem *normalWebViewItem = [RangersAPMCellItem itemWithTitle:@"正常页面" block:normalWebViewBlock];
        
        void(^testWebViewBlock)(void) = ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                RangersAPMWebViewController *webViewController = [RangersAPMWebViewController webViewControllerWithURLString:@"https://datarangers.com.cn/RangersAPM/demo/demo/rangers-site-sdk-npm" title:@"异常测试"];
                [strongSelf.navigationController pushViewController:webViewController animated:YES];
            }
        };
        RangersAPMCellItem *testWebViewItem = [RangersAPMCellItem itemWithTitle:@"异常测试页面" block:testWebViewBlock];
        
        void(^userWebViewBlock)(void) = ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"自定义WebView" message:@"示例 https://www.volcengine.cn" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *url = @"https://www.volcengine.cn";
                    for (UITextField *textField in alert.textFields) {
                        if ([textField.placeholder isEqualToString:kUserWebViewPlaceholder]) {
                            url = textField.text ?: url;
                            break;
                        }
                    }
                    RangersAPMWebViewController *webViewController = [RangersAPMWebViewController webViewControllerWithURLString:url title:@"自定义页面"];
                    [self.navigationController pushViewController:webViewController animated:YES];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:ok];
                [alert addAction:cancel];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = kUserWebViewPlaceholder;
                }];
                [strongSelf presentViewController:alert animated:YES completion:nil];
            }
        };
        RangersAPMCellItem *userWebViewItem = [RangersAPMCellItem itemWithTitle:@"自定义页面" block:userWebViewBlock];
        
        [_items addObject:normalWebViewItem];
        [_items addObject:testWebViewItem];
        [_items addObject:userWebViewItem];
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
