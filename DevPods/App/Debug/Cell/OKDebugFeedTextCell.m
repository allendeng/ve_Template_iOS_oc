//
//  OKDebugFeedTextCell.m
//  OKStartUp
//
//  Created by bob on 2020/4/22.
//

#import "OKDebugFeedTextCell.h"
#import "OKDebugFeedModel.h"

@interface OKDebugFeedTextCell ()

@property (nonatomic, strong) UILabel *cellTitle;

@end

@implementation OKDebugFeedTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 380, 44)];
        [self.contentView addSubview:cellTitle];
        cellTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.cellTitle = cellTitle;
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateWithModel:(OKDebugFeedModel *)model {
    self.cellTitle.text = [NSString stringWithFormat:@"%zd: %@",model.index, model.title];
    self.model = model;
}

+ (NSString *)feedCellReuseIdentifier {
    return NSStringFromClass(self.class);
}

@end
