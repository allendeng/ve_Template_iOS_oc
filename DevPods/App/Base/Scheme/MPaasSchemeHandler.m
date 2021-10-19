//
//  MPaasSchemeHandler.m
//  mPaasDemo
//
//  Created by bob on 2020/1/17.
//  Copyright © 2020 com.mpaas. All rights reserved.
//

#import "MPaasSchemeHandler.h"
#import <OneKit/OKStartUpFunction.h>

OKAppTaskAddFunction() {
    [[OKStartUpSchemeHandler sharedHandler] registerHandler:[MPaasSchemeHandler new]];
}

@implementation MPaasSchemeHandler

- (BOOL)canHandleURL:(NSURL *)URL options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return YES;
}

- (BOOL)handleURL:(NSURL *)URL
      application:(UIApplication *)application
            scene:(nullable id)scene
          options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return YES;
}

@end
