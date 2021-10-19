
#import <OneKit/OKStartUpTask.h>
#import <OneKit/OKStartUpFunction.h>
#import "LoggerStartUpTask.h"

OKAppLoadServiceFunction() {
    [[OKServiceCenter sharedInstance] bindClass:[LogService class] forProtocol:@protocol(OKLogService)];
    
}

OKAppTaskAddFunction() {
    [[LogService sharedInstance] scheduleTask];
}


static NSString *currentTimeString() {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSS"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@implementation LogService

+ (instancetype)sharedInstance {
    static LogService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (void)startWithLaunchOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    
}

- (void)verbose:(NSString *)log {
    fprintf(stderr, "%s %s", [currentTimeString() UTF8String], [log UTF8String]);
}

- (void)debug:(NSString *)log {
    fprintf(stderr, "%s %s", [currentTimeString() UTF8String], [log UTF8String]);
}

- (void)info:(NSString *)log {
    fprintf(stderr, "%s %s", [currentTimeString() UTF8String], [log UTF8String]);
}

- (void)warn:(NSString *)log {
    fprintf(stderr, "%s %s", [currentTimeString() UTF8String], [log UTF8String]);
}

- (void)error:(NSString *)log {
    fprintf(stderr, "%s %s", [currentTimeString() UTF8String], [log UTF8String]);
}

@end
