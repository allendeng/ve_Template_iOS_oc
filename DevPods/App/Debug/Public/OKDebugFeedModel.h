//
//  OKDebugFeedModel.h
//  OKStartUp
//
//  Created by bob on 2020/2/17.
//

#import <UIKit/UIKit.h>
#import <OneKit/OKSectionFunction.h>

NS_ASSUME_NONNULL_BEGIN

#define AddDebugFeedKey "AddDebugFeedKey"
#define AddDebugFeedFunction OK_FUNCTION_EXPORT(AddDebugFeedKey)

#define DebugSettingRegisterKey "DebugSettingRegisterKey"
#define DebugSettingRegisterFunction OK_FUNCTION_EXPORT(DebugSettingRegisterKey)

@class OKDebugFeedModel;

typedef void (^OKDebugFeedNavigateBlock)(OKDebugFeedModel *feed, UINavigationController *navigate);
typedef void (^OKDebugFeedSwitchBlock)(OKDebugFeedModel *feed, BOOL on);
typedef void (^OKDebugFeedInputBlock)(OKDebugFeedModel *feed, NSString *input);

typedef NS_ENUM(NSInteger, OKDebugFeedModelType) {
    OKDebugFeedModelTypeText = 1,
    OKDebugFeedModelTypeSwitch,
    OKDebugFeedModelTypeInput,
};


@interface OKDebugFeedModel : NSObject

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) OKDebugFeedModelType feedType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, nullable) id state;
@property (nonatomic, assign) BOOL showToast;
@property (nonatomic, copy, nullable) OKDebugFeedSwitchBlock switchBlock;
@property (nonatomic, copy, nullable) OKDebugFeedInputBlock inputBlock;
@property (nonatomic, copy, nullable) OKDebugFeedNavigateBlock navigateBlock;

- (CGFloat)height;

@end

@interface OKDebugSectionModel : NSObject

@property (nonatomic, strong, nullable) NSArray<OKDebugFeedModel *> *feeds;
@property (nonatomic, copy, nullable) NSString *title;

- (CGFloat)height;

@end


NS_ASSUME_NONNULL_END
