//
//  DetailContactCell.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/7.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "DetailContactCell.h"

@implementation DetailContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)action_callBtnClickEvent:(id)sender {
    __block NSIndexPath *selIndexPath = [_indexPath copy];
    if (_block) {
        _block(selIndexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
