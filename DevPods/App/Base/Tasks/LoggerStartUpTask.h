#import <OneKit/OKServices.h>

@interface LogService : OKStartUpTask <OKLogService>
+ (instancetype)sharedInstance;
@end
