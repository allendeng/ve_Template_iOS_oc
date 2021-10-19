//
//  BTDExampleLogService.m
//  BTDBridgeKit_Example
//
//  Created by Lixiaopeng on 2021/4/20.
//  Copyright © 2021 Lixiaopeng. All rights reserved.
//

#import "BTDExampleLogService.h"

@implementation BTDExampleLogService

- (void)reportADLogWithParamModel:(BDXBridgeReportADLogMethodParamModel *)paramModel completionHandler:(BDXBridgeMethodCompletionHandler)completionHandler
{
    NSLog(@"Succeeded to report the AD Log :)");
    bdx_invoke_block(completionHandler, nil, nil);
}

- (void)reportAppLogWithParamModel:(BDXBridgeReportAppLogMethodParamModel *)paramModel completionHandler:(BDXBridgeMethodCompletionHandler)completionHandler
{
    NSLog(@"Succeeded to report the App Log :)");
    bdx_invoke_block(completionHandler, nil, nil);
}

- (void)reportMonitorLogWithParamModel:(BDXBridgeReportMonitorLogMethodParamModel *)paramModel completionHandler:(BDXBridgeMethodCompletionHandler)completionHandler
{
    NSLog(@"Failed to report the Monitor Log :(");
    BDXBridgeStatus *status = [BDXBridgeStatus statusWithStatusCode:BDXBridgeStatusCodeFailed message:@"Failed to report the Monitor Log :("];
    bdx_invoke_block(completionHandler, nil, status);
}

@end
