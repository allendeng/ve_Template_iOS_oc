//
//  ExampleJSPatchApplyer.h
//
//  Created by 朱元清 on 2021/2/7.
//

#import <Foundation/Foundation.h>
#if __has_include(<BDHotfix/BDHPatchApplyerProtocol.h>)
#import <BDHotfix/BDHPatchApplyerProtocol.h>
#else
#import "BDHPatchApplyerProtocol.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ExampleJSPatchApplyer : NSObject <BDHPatchApplyerProtocol>

- (BOOL)applyPatch:(BDHotfixPatch *)patch;

@end

NS_ASSUME_NONNULL_END
