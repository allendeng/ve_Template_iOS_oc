//
//  OKDebugFooter.h
//  OKStartUp
//
//  Created by bob on 2020/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *_Nullable (^OKDebugFooterFeedBlock)(void);

@interface OKDebugFooter : NSObject

@property (nonatomic, copy, nullable) NSString *pasteText;
@property (nonatomic, copy, nullable) NSString *pasteTitle;

+ (instancetype)sharedInstance;

- (void)addFooterFeedBlock:(OKDebugFooterFeedBlock)block;
- (NSString *)footerString;

@end

NS_ASSUME_NONNULL_END
