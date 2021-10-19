//
//  OKDebugDefaults.h
//  OKDebugTool
//
//  Created by bob on 2020/5/22.
//

#import "OKDebugFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@class OKDefaults;

@interface OKDebugDefaults : NSObject

@property (nonatomic, strong, readonly) OKDefaults *defaults;

+ (instancetype)sharedInstance;

/// 设置默认值，如果已经有值，则不会覆盖，会持久化
/// 仅支持简单的能序列化的对象，比如数字、字符串
/// 示例如下
/**
 OKAppDebugSettingRegisterFunction () {
    [[OKDebugDefaults sharedInstance] registerDefaultValue:@(YES) forKey:@"app-debug-boe"];
 }
 */
- (void)registerDefaultValue:(nullable id)value forKey:(NSString *)key;

/// 直接读写，用于发生变化时，无需修改，直接使用OKDebugSettingModel配置settingKey即可
- (void)setSettingValue:(nullable id)value forKey:(NSString *)key;
- (nullable id)settingValueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
