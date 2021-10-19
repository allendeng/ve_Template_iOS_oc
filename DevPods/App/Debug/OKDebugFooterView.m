//
//  OKDebugFooterView.m
//  OKStartUp
//
//  Created by bob on 2020/2/27.
//

#import "OKDebugFooterView.h"
#import "OKDebugToast.h"
#import "OKDebugFooter.h"


@interface OKDebugFooterView ()

@property (nonatomic, strong) UILabel *textView;

@end

@implementation OKDebugFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:label];
        self.textView = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = [UIColor blueColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(pasteDidAndUid)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)loadHomeFooter {
    self.textView.text = [[OKDebugFooter sharedInstance] footerString];
    self.pasteText = [OKDebugFooter sharedInstance].pasteText;
}

- (void)setTitle:(NSString *)title {
    self.textView.text = title;
}

- (void)pasteDidAndUid {
    NSString *text = self.pasteText;
    if (![text isKindOfClass:[NSString class]]) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
    [self bds_toastShow:@"已经复制到剪贴板"];
}

@end
