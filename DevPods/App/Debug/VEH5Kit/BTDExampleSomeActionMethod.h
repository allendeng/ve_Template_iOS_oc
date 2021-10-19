//
//  BTDExampleSomeActionMethod.h
//  BTDBridgeKit_Example
//
//  Created by Lixiaopeng on 2021/4/20.
//  Copyright © 2021 Lixiaopeng. All rights reserved.
//

#import <VEH5Kit/VEH5Kit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTDExampleSomeActionMethod : VEH5BridgeMethod

@end

@interface BTDExampleSomeActionMethodParamModel : VEH5BridgeModel

@property (nonatomic, copy) NSString *key;

@end

@interface BTDExampleSomeActionMethodResultModel : VEH5BridgeModel

@property (nonatomic, copy) NSString *key;
@end

NS_ASSUME_NONNULL_END
