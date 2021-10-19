//
//  VEH5WebDebugViewController.m
//  App
//
//  Created by lixiaopeng on 2021/5/24.
//

#import "VEH5WebDebugViewController.h"
#import <VEH5Kit/VEH5Kit.h>
@interface VEH5WebDebugViewController () <UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation VEH5WebDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.tableView];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [VEH5KitManager sharedInstance].offlineDictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSString *content = [[VEH5KitManager sharedInstance].offlineDictionary.allKeys objectAtIndex:indexPath.row];
    NSString *key = [[VEH5KitManager sharedInstance].offlineDictionary.allValues objectAtIndex:indexPath.row];
    content = [NSString stringWithFormat:@"【%@】%@", key, content];
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = content;
    return cell;
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
