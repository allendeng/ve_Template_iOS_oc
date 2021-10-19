//
//  OKDebugTextResultViewController.h
//  OKStartUp
//
//  Created by bob on 2020/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKDebugSectionModel;

@interface OKDebugTextResultViewController : UIViewController

@property (nonatomic, strong) UILabel *textView;

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *pasteText;
@property (nonatomic, copy) NSString *pasteTitle;

@property (nonatomic, strong) NSArray<OKDebugSectionModel *> *feeds;

@end

NS_ASSUME_NONNULL_END
