//
//  BTDExampleAnotherActionMethod.h
//  BTDBridgeKit_Example
//
//  Created by Lixiaopeng on 2021/4/20.
//  Copyright © 2021 Lixiaopeng. All rights reserved.
//

#import <VEH5Kit/VEH5Kit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BTDExampleAnotherActionMethod : VEH5BridgeMethod

@end

@interface BTDExampleAnotherActionMethodParamModel : VEH5BridgeModel

@property (nonatomic, copy) NSString *stringValue;
@property (nonatomic, copy) NSDictionary *dictValue;
@property (nonatomic, strong) NSNumber *numberValue;
@property (nonatomic, assign) BOOL boolValue;

@end

@interface BTDExampleAnotherActionMethodResultModel : VEH5BridgeModel

@property (nonatomic, copy) NSString *stringValue;
@property (nonatomic, copy) NSDictionary *dictValue;
@property (nonatomic, strong) NSNumber *numberValue;
@property (nonatomic, assign) BOOL boolValue;

@end

NS_ASSUME_NONNULL_END
