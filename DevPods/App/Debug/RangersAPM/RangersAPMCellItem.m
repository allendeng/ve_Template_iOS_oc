//
//  RangersAPMCellItem.m
//  RangersAPM_iOS
//
//  Created by xuminghao.eric on 2020/11/12.
//

#import "RangersAPMCellItem.h"

@implementation RangersAPMCellItem

+ (instancetype)itemWithTitle:(NSString *)title block:(dispatch_block_t)block
{
    RangersAPMCellItem *item = [[RangersAPMCellItem alloc] init];
    item.title = title;
    item.selectBlock = block;
    return item;
}

@end
