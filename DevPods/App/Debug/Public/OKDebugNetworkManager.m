//
//  OKDebugNetworkManager.m
//  OKStartUp
//
//  Created by bob on 2020/4/3.
//

#import "OKDebugNetworkManager.h"

static NSCharacterSet *bd_debug_URLQueryAllowedCharacterSet() {
    static NSCharacterSet *turing_set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableCharacterSet *set = [NSMutableCharacterSet new];
        [set formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
        [set addCharactersInString:@"$-_.+!*'(),"];
        turing_set = set;
    });

    return turing_set;
}

static NSString * bd_debug_queryFromDictionary(NSDictionary *params) {
    if (params.count < 1) {
        return nil;
    }

    NSMutableArray *keyValuePairs = [NSMutableArray array];
    for (id key in params) {
        NSString *queryKey = [[key description] stringByAddingPercentEncodingWithAllowedCharacters:bd_debug_URLQueryAllowedCharacterSet()];
        NSString *queryValue = [[params[key] description] stringByAddingPercentEncodingWithAllowedCharacters:bd_debug_URLQueryAllowedCharacterSet()];

        [keyValuePairs addObject:[NSString stringWithFormat:@"%@=%@", queryKey, queryValue]];
    }

    return [keyValuePairs componentsJoinedByString:@"&"];
}

static NSString * bd_debug_requestURLWithQuery(NSString *requestURL, NSDictionary *query) {
    NSString *queryString = bd_debug_queryFromDictionary(query);
    if (queryString.length > 0) {
        if ([requestURL containsString:@"?"]) {
            requestURL = [requestURL stringByAppendingFormat:@"&%@",queryString];
        } else {
            requestURL = [requestURL stringByAppendingFormat:@"?%@",queryString];
        }
    }

    return requestURL;
}

@implementation OKDebugNetworkManager

+ (NSMutableURLRequest *)requestForURL:(NSString *)requestURL
                                method:(NSString *)method
                           headerFiled:(NSDictionary *)headerField
                       queryParameters:(NSDictionary *)queryParameters {
    NSString *finalRequestURL = bd_debug_requestURLWithQuery(requestURL, queryParameters);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:finalRequestURL]];
    [request setHTTPMethod:method];
    request.timeoutInterval = 5;
    if (headerField.count > 0) {
        [headerField enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }

    return request;
}

+ (NSDictionary *)responseData:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error {
    NSDictionary * rs = @{};
    NSInteger statusCode = response.statusCode;
    // 小于 100 非法
    if (statusCode < 100 || error) {
        return rs;
    }
    
    rs = [NSJSONSerialization JSONObjectWithData:data
                                         options:NSJSONReadingAllowFragments
                                           error:nil];
    if (rs == nil) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableDictionary *x = [NSMutableDictionary new];
        [x setValue:result forKey:@"result"];
        rs = x;
        
    }

    return rs;
}

+ (NSDictionary *)syncRequestForURL:(NSString *)requestURL
                             method:(NSString *)method
                        headerFiled:(NSDictionary *)headerField
                    queryParameters:(NSDictionary *)queryParameters {
    NSMutableURLRequest *request = [self requestForURL:requestURL
                                                method:method
                                           headerFiled:headerField
                                       queryParameters:queryParameters];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSMutableDictionary *response = [NSMutableDictionary new];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *taskData,
                                                                                   NSURLResponse *taskResponse,
                                                                                   NSError *taskError) {
        NSDictionary *result = [self responseData:(NSHTTPURLResponse *)taskResponse
                                             data:taskData
                                            error:taskError];
        if ([result isKindOfClass:[NSDictionary class]]
            && result.count > 0) {
            [response addEntriesFromDictionary:result];
        }
        dispatch_semaphore_signal(semaphore);
    }] resume];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC));

    return response;
}

+ (void)addRequest:(NSMutableURLRequest *)request
      withBodyData:(NSDictionary *)parameters {
    if (![parameters isKindOfClass:[NSDictionary class]] || parameters.count < 1) {
        return;
    }

    NSData *sendingData = [NSJSONSerialization dataWithJSONObject:parameters
                                                          options:NSJSONWritingPrettyPrinted
                                                            error:nil];
    [request setHTTPBody:sendingData];
}

+ (void)asyncRequestForURL:(NSString *)requestURL
                    method:(NSString *)method
               headerFiled:(NSDictionary *)headerField
           queryParameters:(NSDictionary *)queryParameters
            postParameters:(NSDictionary *)postParameters
                  callback:(OKDebugNetworkFinishBlock)callback {
    if (callback == nil) {
        return;
    }
    NSMutableURLRequest *request = [self requestForURL:requestURL
                                                method:method
                                           headerFiled:headerField
                                       queryParameters:queryParameters];
    [self addRequest:request withBodyData:postParameters];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *taskData,
                                                                                   NSURLResponse *taskResponse,
                                                                                   NSError *taskError) {
        NSDictionary *result = [self responseData:(NSHTTPURLResponse *)taskResponse
                                             data:taskData
                                            error:taskError];
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(result);
        });
        
    }] resume];
}

@end
