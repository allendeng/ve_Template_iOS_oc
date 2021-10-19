//
//  BTDViewController.h
//  ByteWebKit
//
//  Created by lixiaopeng on 04/19/2021.
//  Copyright (c) 2021 lixiaopeng. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, BTDDebugType) {
    BTDDebugType_debug = 0,
    BTDDebugType_example = 1,
};

@interface BTDViewController : UIViewController
@property (nonatomic ,assign) BTDDebugType btd_type;
@property (nonatomic ,assign) BOOL offlineEnable;

@end
