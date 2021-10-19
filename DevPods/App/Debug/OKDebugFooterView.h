//
//  OKDebugFooterView.h
//  OKStartUp
//
//  Created by bob on 2020/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKDebugFooterView : UIView

@property (nonatomic, copy) NSString *pasteText;

- (void)loadHomeFooter;
- (void)setTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
