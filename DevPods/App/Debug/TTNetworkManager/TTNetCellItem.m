//
//  TTNetCellItem.m
//  ss_app_ios_lib_network
//
//

#import "TTNetCellItem.h"

@implementation TTNetCellItem

+ (instancetype)itemWithTitle:(NSString *)title block:(dispatch_block_t)block
{
    TTNetCellItem *item = [[TTNetCellItem alloc] init];
    item.title = title;
    item.selectBlock = block;
    return item;
}

@end
