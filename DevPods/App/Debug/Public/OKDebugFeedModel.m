//
//  OKDebugFeedModel.m
//  OKStartUp
//
//  Created by bob on 2020/2/17.
//

#import "OKDebugFeedModel.h"

@interface OKDebugFeedModel ()

@end

@implementation OKDebugFeedModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.feedType = OKDebugFeedModelTypeText;
        self.navigateBlock = nil;
        self.switchBlock = nil;
        self.inputBlock = nil;
        self.showToast = YES;
    }
    
    return self;
}

- (CGFloat)height {
    switch (self.feedType) {
        case OKDebugFeedModelTypeText:      return 44;
        case OKDebugFeedModelTypeSwitch:    return 50;
        case OKDebugFeedModelTypeInput:     return 100;
    }
}

@end

@implementation OKDebugSectionModel

- (CGFloat)height {
    return 44;
}

@end
