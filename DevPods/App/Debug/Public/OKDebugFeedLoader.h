//
//  OKDebugFeedLoader.h
//  OKStartUp
//
//  Created by bob on 2020/2/17.
//

#import <Foundation/Foundation.h>

@class OKDebugFeedModel;

NS_ASSUME_NONNULL_BEGIN

@interface OKDebugFeedLoader : NSObject

+ (instancetype)sharedInstance;

+ (NSArray<OKDebugFeedModel *> *)loadDebugHomeFeedList;

+ (void)addDebugFeed:(OKDebugFeedModel *)feed;

@end

NS_ASSUME_NONNULL_END
