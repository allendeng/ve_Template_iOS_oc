//
//  UIViewController+OKDebugAlert.m
//  OKStartUp
//
//  Created by bob on 2020/4/23.
//

#import "UIViewController+OKDebugAlert.h"

@implementation UIViewController (OKDebugAlert)

- (void)bdd_showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
