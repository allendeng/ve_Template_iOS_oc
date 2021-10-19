//
//  OKDebugFooter.m
//  OKStartUp
//
//  Created by bob on 2020/3/31.
//

#import "OKDebugFooter.h"

@interface OKDebugFooter ()

@property (nonatomic, strong) NSMutableArray<NSString *> *feed;
@property (nonatomic, strong) NSMutableArray<OKDebugFooterFeedBlock> *feedBlock;

@end

@implementation OKDebugFooter

+ (instancetype)sharedInstance {
    static OKDebugFooter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.pasteText = nil;
        self.pasteTitle = nil;
        NSMutableArray<NSString *> *feed = [NSMutableArray new];
        [feed addObject:@"All Rights Reserved By OneKit"];
        self.feed = feed;
        self.feedBlock = [NSMutableArray new];
    }
    
    return self;
}

- (NSString *)footerString {
    NSMutableArray<NSString *> *feeds = [self.feed mutableCopy];
    NSMutableArray<OKDebugFooterFeedBlock> *feedBlock = self.feedBlock;
    if (feedBlock.count > 0) {
        for (OKDebugFooterFeedBlock block in feedBlock) {
            NSString *feed = block();
            if (feed) {
                [feeds addObject:feed];
            }
        }
    }
    
    if (self.pasteTitle) {
        [feeds addObject:self.pasteTitle];
    }
    
    return [feeds componentsJoinedByString:@"\n"];
}

- (void)addFooterFeedBlock:(OKDebugFooterFeedBlock)block {
    if (block != nil) {
        [self.feedBlock addObject:block];
    }
}

@end
