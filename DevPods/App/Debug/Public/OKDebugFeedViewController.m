//
//  OKDebugFeedViewController.m
//  OKStartUp
//
//  Created by bob on 2020/2/17.
//

#import "OKDebugFeedViewController.h"
#import "OKDebugFeedModel.h"
#import "OKDebugFeedLoader.h"
#import "OKDebugFooterView.h"
#import "OKDebugFeedAdapter.h"
#import <OneKit/OKStartUpFunction.h>
#import <OneKit/OKScreenshotTools.h>
#import "OKDebugTextResultViewController.h"
#import "OKDebugDefaultsModel.h"

#if defined __has_include
# if __has_include("APMHomeViewController.h")
#  include "APMHomeViewController.h"
# endif
# if __has_include("BDTestIntroducerViewController.h")
#  include "BDTestIntroducerViewController.h"
# endif
# if __has_include("TTNetViewController.h")
#  include "TTNetViewController.h"
# endif
# if __has_include("OKScreenshotViewController.h")
#  include "OKScreenshotViewController.h"
# endif
# if __has_include("BTDEntryViewController.h")
#  include "BTDEntryViewController.h"
# endif
# if __has_include("BDHTestViewController.h")
#  include "BDHTestViewController.h"
# endif
# if __has_include("TTViewController.h")
#  include "TTViewController.h"
# endif
#endif

static NSString *const kOKStartUpDebugAppID     = @"kOKStartUpDebugAppID";
static NSString *const kOKStartUpDebugChannel   = @"kOKStartUpDebugChannel";
static NSString *const kOKStartUpDebugAppName   = @"kOKStartUpDebugAppName";

@interface OKDebugFeedViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OKDebugFooterView *footerView;
@property (nonatomic, strong) OKDebugFeedAdapter *adapter;

@end

@implementation OKDebugFeedViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat height = self.view.bounds.size.height;
    CGFloat width = self.view.bounds.size.width;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat footerHeight = 150;
    if (@available(iOS 11.0, *)) {
        footerHeight = keyWindow.safeAreaInsets.bottom + 120;
    }
    OKDebugFooterView *footer = [[OKDebugFooterView alloc] initWithFrame:CGRectMake(0, height - footerHeight, width, footerHeight)];
    [footer loadHomeFooter];
    [self.view addSubview:footer];
    self.footerView = footer;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - footerHeight)
                                                  style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [OKDebugFeedLoader addDebugFeed:({
        OKDebugFeedModel *model = [OKDebugFeedModel new];
        model.title = @"APP基础信息设置";
        model.navigateBlock = ^(OKDebugFeedModel *feed, UINavigationController *navigate) {
            OKDebugTextResultViewController *result = [OKDebugTextResultViewController new];
            result.title = @"APP基础信息设置";
            result.feeds = [OKDebugFeedViewController baseFeedsNavigate:navigate];
            [navigate pushViewController:result animated:YES];
        };
        model;
    })];
    
    
    
#if defined __has_include
# if __has_include("APMHomeViewController.h")
    [self addFeedEntry:@"RangersAPM功能测试" forViewController:APMHomeViewController.class];
# endif
# if __has_include("BDTestIntroducerViewController.h")
    [self addFeedEntry:@"RangersAppLog测试" forViewController:BDTestIntroducerViewController.class];
# endif
# if __has_include("TTNetViewController.h")
    [self addFeedEntry:@"TTNetwork功能测试" forViewController:TTNetViewController.class];
# endif
# if __has_include("OKScreenshotViewController.h")
    [self addFeedEntry:@"截屏" forViewController:OKScreenshotViewController.class];
# endif
# if __has_include("BTDEntryViewController.h")
    [self addFeedEntry:@"H5 服务" forViewController:BTDEntryViewController.class];
# endif
    
    
# if __has_include("BDHTestViewController.h")
    [self addFeedEntry:@"热修复测试" forViewController:BDHTestViewController.class];
# endif
    
    
# if __has_include("TTViewController.h")
    [self addFeedEntry:@"发布测试" forViewController:TTViewController.class];
# endif
    
#endif
    
    
    
    
    
    
    NSMutableArray<OKDebugSectionModel *> *feeds = [NSMutableArray new];
    [feeds addObject:({
        OKDebugSectionModel *model = [OKDebugSectionModel new];
        model.title = @"SDK示例列表";
        model.feeds = [OKDebugFeedLoader loadDebugHomeFeedList];
        model;
    })];
    OKDebugFeedAdapter *adapter = [[OKDebugFeedAdapter alloc] initWithFeeds:feeds
                                                                   navigate:self.navigationController];
    [adapter registerTableView:self.tableView];
    self.tableView.dataSource = adapter;
    self.tableView.delegate = adapter;
    self.adapter = adapter;
    self.navigationItem.title = @"测试体验功能";
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(clickLeft)];
}

-(void)addFeedEntry: (NSString *) title forViewController: (Class) viewController{
    [OKDebugFeedLoader addDebugFeed:({
        OKDebugFeedModel *model = [OKDebugFeedModel new];
        model.title = title;
        model.navigateBlock = ^(OKDebugFeedModel *feed, UINavigationController *navigate) {
            [navigate pushViewController:[viewController new] animated:YES];
        };
        model;
    })];
        
}

+ (NSArray<OKDebugSectionModel *> *)baseFeedsNavigate:(UINavigationController *)navigate  {
    NSMutableArray<OKDebugSectionModel *> *sections = [NSMutableArray new];

    [sections addObject:({
        OKDebugSectionModel *model = [OKDebugSectionModel new];
        model.title = @"基本信息设置";
        NSMutableArray<OKDebugFeedModel *> *feeds = [NSMutableArray new];

        
        [feeds addObject:({
            OKDebugSettingModel *setting = [OKDebugSettingModel new];
            setting.title = @"修改APPID";
            setting.feedType = OKDebugFeedModelTypeInput;
            setting.settingKey = kOKStartUpDebugAppID;
            setting;
        })];
        
        [feeds addObject:({
            OKDebugSettingModel *setting = [OKDebugSettingModel new];
            setting.title = @"修改APPName";
            setting.feedType = OKDebugFeedModelTypeInput;
            setting.settingKey = kOKStartUpDebugAppName;
            setting;
        })];
        
        [feeds addObject:({
            OKDebugSettingModel *setting = [OKDebugSettingModel new];
            setting.title = @"修改channel";
            setting.feedType = OKDebugFeedModelTypeInput;
            setting.settingKey = kOKStartUpDebugChannel;
            setting;
        })];
        
        for (NSUInteger count = 0; count < 7; count++) {
            [feeds addObject:({
                OKDebugFeedModel *setting = [OKDebugFeedModel new];
                setting.title = @"占位";
                setting;
            })];
        }
        model.feeds = feeds;
        model;
    })];
    
    return sections;
}

- (void)clickLeft {
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.presentingViewController)  {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
