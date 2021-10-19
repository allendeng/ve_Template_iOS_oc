//
//  OKDebugToast.m
//  OKStartUp
//
//  Created by bob on 2020/2/27.
//

#import "OKDebugToast.h"

@implementation UIView (OKDebugToast)

- (UILabel *)bds_toastLabel:(NSString *)message {
    UILabel *messageView = [UILabel new];
    messageView.layer.cornerRadius = 8;
    messageView.layer.masksToBounds = YES;
    messageView.backgroundColor = [UIColor blackColor];
    messageView.numberOfLines = 0;
    messageView.textAlignment = NSTextAlignmentCenter;
    messageView.textColor = [UIColor whiteColor];
    UIFont *font = [UIFont systemFontOfSize:15];
    messageView.font = font;
    messageView.alpha = 0.8;

    CGRect rect = [message boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    CGFloat width = rect.size.width + 20;
    CGFloat height = rect.size.height + 20;
    messageView.frame = CGRectMake(0, 0, width, height);
    messageView.text = message;

    return messageView;
}

- (void)bds_toastShow:(NSString *)message {
    UILabel *toastView = [self bds_toastLabel:message];
    CGSize parent = self.frame.size;
    CGSize toast = toastView.frame.size;
    toastView.frame = CGRectMake((parent.width - toast.width)/2,
                                 (parent.height - toast.height)/2,
                                 toast.width,
                                 toast.height);
    [self addSubview:toastView];
    [UIView animateWithDuration:0.2f delay:2.0f options:(UIViewAnimationOptionCurveLinear) animations:^{
        toastView.alpha = 0;
    } completion:^(BOOL finished) {
        [toastView removeFromSuperview];
    }];
}

@end
