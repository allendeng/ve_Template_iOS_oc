//
//  OKStartUpUITask.m
//  OKStartUp
//
//  Created by chenshu on 2020/5/7.
//

#import "OKStartUpUITask.h"
#import "OKFeedViewController.h"

#import <OneKit/OKStartUpFunction.h>

OKAppTaskAddFunction () {
    [[OKStartUpUITask new] scheduleTask];
}

@implementation OKStartUpUITask

- (void)startWithLaunchOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[self rootVC]];
        window.rootViewController = nav;
        [window makeKeyAndVisible];
        [UIApplication sharedApplication].delegate.window = window;
    });
}

- (UIViewController *)rootVC {
    Class claszz = NSClassFromString(@"OKDebugFeedViewController") ?: [OKFeedViewController class];
    return [claszz new];
}

@end
