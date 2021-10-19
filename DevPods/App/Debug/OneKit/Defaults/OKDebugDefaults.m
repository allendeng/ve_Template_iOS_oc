//
//  OKDebugDefaults.m
//  OKDebugTool
//
//  Created by bob on 2020/5/22.
//

#import "OKDebugDefaults.h"
#import <OneKit/OKDefaults.h>

@interface OKDebugDefaults ()

@property (nonatomic, strong) OKDefaults *defaults;

@end

@implementation OKDebugDefaults

+ (instancetype)sharedInstance {
    static OKDebugDefaults *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.defaults = [OKDefaults defaultsWithIdentifier:@"mpaas/inhouse_settings.plist"];
    }
    
    return self;
}

- (void)setSettingValue:(id)value forKey:(NSString *)key {
    [self.defaults setDefaultValue:value forKey:key];
}

- (void)registerDefaultValue:(id)value forKey:(NSString *)key {
    if (![self.defaults defaultValueForKey:key]) {
        [self.defaults setDefaultValue:value forKey:key];
    }
}

- (id)settingValueForKey:(NSString *)key {
    return [self.defaults defaultValueForKey:key];
}

@end
