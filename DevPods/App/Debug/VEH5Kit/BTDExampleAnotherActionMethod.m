//
//  BTDExampleAnotherActionMethod.m
//  BTDBridgeKit_Example
//
//  Created by Lixiaopeng on 2021/4/20.
//  Copyright © 2021 Lixiaopeng. All rights reserved.
//

#import "BTDExampleAnotherActionMethod.h"

@implementation BTDExampleAnotherActionMethod

- (NSString *)methodName
{
    return @"o.anotherAction";
}

- (BDXBridgeAuthType)authType
{
    return BDXBridgeAuthTypePublic;
}

- (Class)paramModelClass
{
    return BTDExampleAnotherActionMethodParamModel.class;
}

- (Class)resultModelClass
{
    return BTDExampleAnotherActionMethodResultModel.class;
}

- (void)callWithParamModel:(BTDExampleAnotherActionMethodParamModel *)paramModel completionHandler:(BDXBridgeMethodCompletionHandler)completionHandler
{
    NSLog(@"Failed to do another action with param model: %@!", paramModel);
    BDXBridgeStatus *status = [BDXBridgeStatus statusWithStatusCode:BDXBridgeStatusCodeFailed message:@"Failed to do another action with param model: %@!", paramModel];
    bdx_invoke_block(completionHandler, nil, status);
}

@end

@implementation BTDExampleAnotherActionMethodParamModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"stringValue": @"stringValue",
        @"dictValue": @"dictValue",
        @"numberValue": @"numberValue",
        @"boolValue": @"boolValue",
    };
}

@end

@implementation BTDExampleAnotherActionMethodResultModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"stringValue": @"stringValue",
        @"dictValue": @"dictValue",
        @"numberValue": @"numberValue",
        @"boolValue": @"boolValue",
    };
}

@end
