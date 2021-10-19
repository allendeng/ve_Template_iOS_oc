//
//  OKDebugFeedInputCell.m
//  OKStartUp
//
//  Created by bob on 2020/4/22.
//

#import "OKDebugFeedInputCell.h"
#import "OKDebugFeedModel.h"

@interface OKDebugFeedInputCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *input;


@end

@implementation OKDebugFeedInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize contentSize = self.contentView.bounds.size;
        UITextField *textFieldDID = [[UITextField alloc] initWithFrame:CGRectMake(32, contentSize.height - 50, 300, 44)];
        textFieldDID.borderStyle = UITextBorderStyleRoundedRect;
        textFieldDID.delegate = self;
        textFieldDID.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        self.input = textFieldDID;
        [self.contentView addSubview:textFieldDID];
    }

    return self;
}

- (void)updateWithModel:(OKDebugFeedModel *)model {
    [super updateWithModel:model];
    self.input.text = [NSString stringWithFormat:@"%@", model.state];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    OKDebugFeedModel *model = self.model;
    NSString *state = textField.text;
    model.state = state;
    OKDebugFeedInputBlock inputBlock = model.inputBlock;
    if (inputBlock) {
        inputBlock(model, state);
    }
    [textField resignFirstResponder];
    return YES;
}

@end
