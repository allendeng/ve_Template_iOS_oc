//
//  OKDebugFeedSwitchCell.m
//  OKStartUp
//
//  Created by bob on 2020/4/22.
//

#import "OKDebugFeedSwitchCell.h"
#import "OKDebugFeedModel.h"

@interface OKDebugFeedSwitchCell ()

@property (nonatomic, strong) UISwitch *sw;

@end


@implementation OKDebugFeedSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize contentSize = self.contentView.bounds.size;
        UISwitch *sw = [UISwitch new];
        CGSize swSize = sw.bounds.size;
        sw.frame = CGRectMake(contentSize.width - swSize.width - 32,
                               (contentSize.height - swSize.height)/2,
                              swSize.width,
                              swSize.height);
        [self.contentView addSubview:sw];
        [sw addTarget:self action:@selector(onSwitchChange:)forControlEvents:UIControlEventValueChanged];
        sw.onTintColor = [UIColor blueColor];
        sw.tintColor = [UIColor grayColor];
        sw.on = YES;
        sw.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        self.sw = sw;
    }

    return self;
}

- (void)updateWithModel:(OKDebugFeedModel *)model {
    [super updateWithModel:model];
    self.sw.on = [model.state boolValue];
}

- (void)onSwitchChange:(UISwitch *)sw {
    NSNumber *state = @(sw.isOn);
    OKDebugFeedModel *model = self.model;
    model.state = state;
    OKDebugFeedSwitchBlock switchBlock = model.switchBlock;
    if (switchBlock) {
        switchBlock(model, sw.isOn);
    }
}

@end
