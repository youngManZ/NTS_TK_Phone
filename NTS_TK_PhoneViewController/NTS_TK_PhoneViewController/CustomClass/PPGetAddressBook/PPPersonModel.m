//
//  PPAddressModel.m
//  PPAddressBook
//
//  Created by AndyPang on 16/8/17.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import "PPPersonModel.h"
#import "AddressBookModel.h"
#import <YYDispatchQueuePool.h>

@implementation PPPersonModel

- (NSMutableArray *)mobileArray
{
    if(!_mobileArray)
    {
        _mobileArray = [NSMutableArray array];
    }
    return _mobileArray;
}

- (void)getAddressWithBlock:(PPPersonModelAddressBlock)block {
    if (_mobileArray.count > 0) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *addStr = [[AddressBookModel sharedManager] attributionWithPhoneNumber:[_mobileArray objectAtIndex:0]];
            if (addStr.length == 0) {
                _address = @"未知归属地";
            }else {
                _address = [NSString stringWithFormat:@"%@",addStr];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                block(_address);
            });
        });
    }else {
        _address = @"未知归属地";
        block(_address);
    }
}

@end
