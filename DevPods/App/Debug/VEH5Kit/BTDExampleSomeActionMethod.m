//
//  BTDExampleSomeActionMethod.m
//  BTDBridgeKit_Example
//
//  Created by Lixiaopeng on 2021/4/20.
//  Copyright © 2021 Lixiaopeng. All rights reserved.
//

#import "BTDExampleSomeActionMethod.h"

@implementation BTDExampleSomeActionMethod
//BTD_bridge_register_external_global_method(BTDExampleSomeActionMethod);

- (NSString *)methodName
{
    return @"o.openDialog";
}

- (BDXBridgeAuthType)authType
{
    return BDXBridgeAuthTypePublic;
}

- (Class)paramModelClass
{
    return BTDExampleSomeActionMethodParamModel.class;
}

- (Class)resultModelClass
{
    return BTDExampleSomeActionMethodResultModel.class;
}

- (void)callWithParamModel:(BTDExampleSomeActionMethodParamModel *)paramModel completionHandler:(BDXBridgeMethodCompletionHandler)completionHandler
{
    NSLog(@"Succeeded to do some action with param model: %@!", paramModel);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"测试弹窗" message:@"你好 Demo" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    BTDExampleSomeActionMethodResultModel *resultModel = [BTDExampleSomeActionMethodResultModel new];
    resultModel.key = @"content";
    bdx_invoke_block(completionHandler, resultModel, nil);
}

@end

@implementation BTDExampleSomeActionMethodParamModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"key": @"key"
    };
}

@end

@implementation BTDExampleSomeActionMethodResultModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"key": @"key",
    };
}

@end
