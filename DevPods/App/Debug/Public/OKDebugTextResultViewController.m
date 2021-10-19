//
//  OKDebugTextResultViewController.m
//  OKStartUp
//
//  Created by bob on 2020/2/28.
//

#import "OKDebugTextResultViewController.h"
#import "OKDebugFooterView.h"
#import "OKDebugFeedAdapter.h"

@interface OKDebugTextResultViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OKDebugFeedAdapter *adapter;

@end

@implementation OKDebugTextResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = self.view.bounds.size.height;
    CGFloat width = self.view.bounds.size.width;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat footerHeight = 150;
    if (@available(iOS 11.0, *)) {
        footerHeight = keyWindow.safeAreaInsets.bottom + 120;
    }
    OKDebugFooterView *footer = [[OKDebugFooterView alloc] initWithFrame:CGRectMake(0, height - footerHeight, width, footerHeight)];
    [self.view addSubview:footer];
    if (self.pasteText.length > 0) {
        footer.pasteText = self.pasteText;
        NSString *title = self.pasteTitle ?: @"点击复制URL";
        [footer setTitle:title];
    } else {
        footerHeight = 0;
    }
    
    CGFloat header = 400;
    if (self.result.length > 0) {
        UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, header)];
        textView.textAlignment = NSTextAlignmentLeft;
        textView.numberOfLines = 0;
        textView.userInteractionEnabled = YES;
        self.textView = textView;
        textView.text = self.result;
        [self.view addSubview:textView];
    } else {
        header = 0;
    }
    
    if (self.feeds.count > 0) {
        OKDebugFeedAdapter *adapter = [[OKDebugFeedAdapter alloc] initWithFeeds:self.feeds
                                                                       navigate:self.navigationController];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                               header,
                                                                               width,
                                                                               height - header - footerHeight)
                                                              style:(UITableViewStylePlain)];
        
        [adapter registerTableView:tableView];
        tableView.dataSource = adapter;
        tableView.delegate = adapter;
        [self.view addSubview:tableView];
        self.adapter = adapter;
        self.tableView = tableView;
    }
}

@end
