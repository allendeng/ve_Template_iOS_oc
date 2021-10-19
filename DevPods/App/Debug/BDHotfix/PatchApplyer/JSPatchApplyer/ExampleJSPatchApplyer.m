//
//  ExampleJSPatchApplyer.m
//
//  Created by 朱元清 on 2021/2/7.
//

#import "ExampleJSPatchApplyer.h"
#import "JPEngine.h"

@implementation ExampleJSPatchApplyer

/*
 注：实际使用中，JSPatch需要经过混淆处理。这里的实现也要根据混淆后的符号来调整。
 */
- (BOOL)applyPatch:(BDHotfixPatch *)patch {
    for (NSString *filePath in patch.files) {
        /* 处理Patch包中的文件。上传的是什么，这里就是什么。 */
        if ([filePath.pathExtension isEqualToString:@"js"]) {
            [JPEngine evaluateScriptWithPath:filePath];
            NSLog(@"[JSPatchApplyer] 成功应用Patch at %@", filePath);
        }
    }
    
    return YES;
}

@end
