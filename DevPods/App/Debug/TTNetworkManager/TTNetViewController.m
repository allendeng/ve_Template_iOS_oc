//
//  TTNetViewController.m
//  ss_app_ios_lib_network
//

#import "TTNetViewController.h"
#import "TTNetCellItem.h"
#import <TTNetworkManager/TTNetworkManager.h>
#import <TTNetworkManager/TTHttpResponseChromium.h>

@interface TTNetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSMutableArray *items;

@end

@implementation TTNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TTNetCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 600)];
    self.label.text = @"";
    self.label.adjustsFontSizeToFitWidth = NO;
    self.label.numberOfLines = 0;

    self.tableView.tableFooterView = self.label;
    
    [self.view addSubview:self.tableView];

    self.title = @"TTNet";
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
        
        TTNetCellItem *requestItem = [TTNetCellItem itemWithTitle:@"获取JSON" block:^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"获取JSON"
                                                                                   message:@"请求URL："
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"发送请求" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       if (alert.textFields.count > 0) {
                                                                           UITextField *textField = [alert.textFields firstObject];
                                                                           NSString *url = textField.text;
                                                                           url = url.length == 0 ? textField.placeholder : url;
                                                                           [strongSelf URLRequest:url];
                                                                       }
                                                                   }];
                    [alert addAction:submit];
                    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                        textField.placeholder = @"https://ic.snssdk.com/api/2/article/v28/stream/";
                    }];
                    [strongSelf presentViewController:alert animated:YES completion:nil];
                }
            });
        }];
        

        [_items addObject:requestItem];
    }
    
    return _items;
}

- (void)URLRequest:(NSString *)URL{
    [[TTNetworkManager shareInstance] requestForJSONWithResponse:URL
                                                          params:@{}
                                                          method:@"GET"
                                                needCommonParams:YES
                                                        callback:^(NSError *error, id jsonObj, TTHttpResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error %@", error);
            NSLog(@"jsonObj %@", jsonObj);
            NSLog(@"requestLog %@", ((TTHttpResponseChromium *)response).requestLog);
            self.label.text = @"JSON: ";
            if (error) {
                self.label.text = error.description;
                NSLog(@"****outer callback,response:%@, jsonObj:%@, error:%@", response, jsonObj, error);
            } else {
                NSError *err = nil;
                NSString *jsonString = nil;
                if (![NSJSONSerialization isValidJSONObject:jsonObj]) {
                    NSLog(@"response is not a valid json");
                    self.label.text = @"response is not a valid json";
                    return;
                }

                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj options:NSJSONWritingPrettyPrinted error:&err];
                if (err) {
                    NSLog(@"json serialization failed,error:%@",err);
                } else {
                    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                }
                self.label.text = [self.label.text stringByAppendingFormat:@"%@", jsonString];
                NSString *requestLog = ((TTHttpResponseChromium *)response).requestLog;
                self.label.text = [self.label.text stringByAppendingFormat:@"\n\n%@",requestLog];
            }
        });
    }];
}

#pragma mark UITableViewDelegate, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTNetCell"];
    TTNetCellItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",item.title];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTNetCellItem *item = [self.items objectAtIndex:indexPath.row];
    if (item.selectBlock) {
        item.selectBlock();
    } 
}

@end
