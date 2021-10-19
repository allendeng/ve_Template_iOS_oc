//
//  APMStartUpTask.m
//  App
//
//  Created by bytedance on 2021/4/25.
//

#import "APMStartUpTask.h"
#import <RangersAPM/RangersAPM.h>
#import <RangersAPM/RangersAPM+DebugLog.h>
#import <OneKit/OKStartUpFunction.h>
#import <OneKit/OKApplicationInfo.h>

OKAppTaskAddFunction () {
    [[APMStartUpTask new] scheduleTask];
}

@implementation APMStartUpTask

- (void)startWithLaunchOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    OKApplicationInfo *info = [OKApplicationInfo sharedInstance];
    // APM Init
    RangersAPMConfig *apmConfig = [RangersAPMConfig configWithAppID:info.appID];
    apmConfig.channel = info.channel;
    apmConfig.deviceIDSource = RAPMDeviceIDSourceFromUser;
    
    // APM Log
    dispatch_sync(dispatch_get_main_queue(), ^{
        [RangersAPM allowDebugLogUsingLogger:nil];
        [RangersAPM startWithConfig:apmConfig];
    });
}
@end
