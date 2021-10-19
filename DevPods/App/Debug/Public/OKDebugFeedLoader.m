//
//  OKDebugFeedLoader.m
//  OKStartUp
//
//  Created by bob on 2020/2/17.
//

#import "OKDebugFeedLoader.h"
#import "OKDebugFeedModel.h"
#import <OneKit/OKSectionFunction.h>

@interface OKDebugFeedLoader ()

@property (nonatomic, strong) NSMutableArray<OKDebugFeedModel *> *feed;

@end

@implementation OKDebugFeedLoader

+ (instancetype)sharedInstance {
    static OKDebugFeedLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.feed =  [NSMutableArray new];
    }
    
    return self;
}

+ (NSArray<OKDebugFeedModel *> *)loadDebugHomeFeedList {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[OKSectionFunction sharedInstance] excuteFunctionsForKey:@DebugSettingRegisterKey];
    });
    
    return [OKDebugFeedLoader sharedInstance].feed;
}

+ (void)addDebugFeed:(OKDebugFeedModel *)feed {
    feed.showToast = NO;
    [[OKDebugFeedLoader sharedInstance].feed addObject:feed];
}

@end
