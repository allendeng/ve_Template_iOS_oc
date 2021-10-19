//
//  OKDebugNetworkManager.h
//  OKStartUp
//
//  Created by bob on 2020/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^OKDebugNetworkFinishBlock)(NSDictionary * _Nullable jsonObj);


@interface OKDebugNetworkManager : NSObject

+ (NSDictionary *)syncRequestForURL:(NSString *)requestURL
                             method:(NSString *)method
                        headerFiled:(nullable NSDictionary *)headerField
                    queryParameters:(nullable NSDictionary *)queryParameters;

+ (void)asyncRequestForURL:(NSString *)requestURL
                    method:(NSString *)method
               headerFiled:(nullable NSDictionary *)headerField
           queryParameters:(nullable NSDictionary *)queryParameters
            postParameters:(nullable NSDictionary *)postParameters
                  callback:(OKDebugNetworkFinishBlock)callback;
@end

NS_ASSUME_NONNULL_END
