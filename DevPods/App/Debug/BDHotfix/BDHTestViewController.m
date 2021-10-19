//
//  ViewController.m
//  BDHotfix
//
//  Created by zlrs on 02/09/2021.
//  Copyright (c) 2021 zlrs. All rights reserved.
//

#import "BDHTestViewController.h"
#import <BDHotfix/BDHotfix.h>
#import "ExampleJSPatchApplyer.h"

@interface BDHTestViewController ()

@property (nonatomic) UIButton *applyJSPatchBtn;

@property (nonatomic) UIButton *syncPatchBtn;
@end

@implementation BDHTestViewController

+ (void)load
{
    [[BDHotfix sharedInstance] setPatchApplyer:[ExampleJSPatchApplyer new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.applyJSPatchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyJSPatchBtn.frame = CGRectMake(50, 140, 250, 60);
    self.applyJSPatchBtn.backgroundColor = [UIColor lightGrayColor];
    [self.applyJSPatchBtn setTitle:@"执行需要修复的代码(JSPatch)" forState:UIControlStateNormal];
    [self.applyJSPatchBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.applyJSPatchBtn addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.applyJSPatchBtn];
    
    self.syncPatchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.syncPatchBtn.frame = CGRectMake(50, 350, 250, 60);
    self.syncPatchBtn.backgroundColor = [UIColor lightGrayColor];
    [self.syncPatchBtn setTitle:@"拉取热修包列表" forState:UIControlStateNormal];
    [self.syncPatchBtn setTintColor:[UIColor blueColor]];
    [self.syncPatchBtn addTarget:self action:@selector(syncPatchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.syncPatchBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1e3), dispatch_get_main_queue(), ^{
//        [self setupView];
//    });
}

- (void)btnTouched:(id)sender {
    if (sender == self.applyJSPatchBtn) {
        /* 应用JSPatch的按钮被按下 */
        NSLog(@"[yq-debug]应用JSPatch的按钮被按下");
        [self changeView];
    }
}

#pragma mark - jspatch
- (void)changeView {
    // will be replaced by jspatch
}


- (IBAction)syncPatchBtnClicked:(id)sender {
    [[BDHotfix sharedInstance] sync];
}

@end
