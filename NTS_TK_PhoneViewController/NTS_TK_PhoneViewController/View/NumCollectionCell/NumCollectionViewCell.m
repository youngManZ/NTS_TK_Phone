//
//  NumCollectionViewCell.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/4.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "NumCollectionViewCell.h"

@implementation NumCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setCenterImage:(UIImage *)centerImage {
    [_titleLabel setText:@""];
    [_iconView setImage:centerImage];
    [_iconView setHidden:NO];
    _iconCenterYLayout.constant = -2;
    _iconHLayout.constant = 28;
    _iconWlayout.constant = 28;
}

- (void)setCopyImage:(UIImage *)copyImage {
    [_titleLabel setText:@""];
    [_iconView setImage:copyImage];
    [_iconView setHidden:NO];
    _iconCenterYLayout.constant = -5;
    _iconHLayout.constant = 20;
    _iconWlayout.constant = 20;
}

@end
