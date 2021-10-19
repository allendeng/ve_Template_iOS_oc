//
//  OKDebugSettingModel.m
//  OKDebugTool
//
//  Created by bob on 2020/5/22.
//

#import "OKDebugDefaultsModel.h"
#import "OKDebugDefaults.h"

@implementation OKDebugSettingModel

- (void)setState:(id)state {
    [[OKDebugDefaults sharedInstance] setSettingValue:state forKey:self.settingKey];
}

- (id)state {
    return [[OKDebugDefaults sharedInstance] settingValueForKey:self.settingKey];
}

@end
