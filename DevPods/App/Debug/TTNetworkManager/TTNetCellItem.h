//
//  TTNetCellItem.h
//  ss_app_ios_lib_network
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTNetCellItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) dispatch_block_t selectBlock;

+ (instancetype)itemWithTitle:(NSString *)title block:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
