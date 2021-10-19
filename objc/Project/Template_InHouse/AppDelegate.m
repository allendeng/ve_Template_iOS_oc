//
//  AppDelegate.m
//  Template_InHouse
//
//  Created by Bob on 2020/3/30.
//  Copyright © 2020 ByteDance. All rights reserved.
//

#import "AppDelegate.h"
#import <OneKit/OneKitApp.h>
#import <OneKit/OKStartUpSchemeHandler.h>
#import <OneKit/OKServiceCenter.h>
#import <OneKit/OKServices.h>
#import <OneKit/OKApplicationInfo.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [OneKitApp startWithLaunchOptions:launchOptions];
    OKLOG_PROTOCOL_DEBUG_TAG(@"TAG", @"Test log %@",launchOptions);
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {

  BOOL handled = [[OKStartUpSchemeHandler sharedHandler] handleURL:url
                                                       application:app
                                                             scene:nil
                                                           options:options];
  if (handled) {
      return YES;
  }

  return [super application:app openURL:url options:options];
}


@end
