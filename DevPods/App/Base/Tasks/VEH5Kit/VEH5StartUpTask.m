//
//  OKStartUpTask+VEH5StartUpTask.m
//  App
//
//  Created by 谭正豪 on 2021/7/4.
//

#import "VEH5StartUpTask.h"
#import <VEH5Kit/VEH5KitManager.h>
#import <VEH5Kit/VEH5Kit.h>

#import <OneKit/OKServices.h>
#import <OneKit/OKApplicationInfo.h>
#import <OneKit/OKStartUpFunction.h>
#import <OneKit/OKServiceCenter.h>

OKAppTaskAddFunction () {
    [[VEH5StartUpTask new] scheduleTask];
}

@implementation VEH5StartUpTask

- (void)startWithLaunchOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    VEH5KitConfig *config = [[VEH5KitConfig alloc] init];
    OKApplicationInfo *info = [OKApplicationInfo sharedInstance];
    config.appID = info.appID;
    config.accessKey = info.accessKey;
    config.appVersion = info.appVersion;
    config.accessKey = info.accessKey;
    config.secretKey = info.secretKey;
    config.isInhouseApp = info.isInhouseApp;
    __block id<OKDeviceService> deviceService = [[OKServiceCenter sharedInstance] serviceForProtocol:@protocol(OKDeviceService)];
    config.getDeviceIDBlock = ^NSString * _Nonnull{
        if (!deviceService) {
            deviceService = [[OKServiceCenter sharedInstance] serviceForProtocol:@protocol(OKDeviceService)];
        }
        return [deviceService.deviceID copy];
    };
    config.startTTNetwork = YES;
    
    /* JSBridge */
    config.authDomain = info.serviceInfo[@"services"][@"jsbridge_services"][@"auth_domain"];
    
    /* Gecko */
    config.platformDomain = info.serviceInfo[@"services"][@"gecko_services"][@"platform_domain"];
    config.pattern = info.serviceInfo[@"services"][@"gecko_services"][@"pattern"];
    config.geckoChannels = info.serviceInfo[@"services"][@"gecko_services"][@"gecko_channels"];
    config.geckoAccessKey = info.serviceInfo[@"services"][@"gecko_services"][@"gecko_access_key"];
    
    [[VEH5KitManager sharedInstance] startUpWithConfig:config];
}

@end
    
