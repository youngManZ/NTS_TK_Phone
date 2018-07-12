//
//  CardChargeVC.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/7/11.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "CardChargeVC.h"

@interface CardChargeVC ()
@property (strong, nonatomic) IBOutlet UIView *chargeView;
@property (strong, nonatomic) IBOutlet UIButton *chargeBtn;

@end

@implementation CardChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值卡充值";
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    
    [_chargeView.layer setMasksToBounds:YES];
    [_chargeView.layer setCornerRadius:5];
    [_chargeBtn.layer setMasksToBounds:YES];
    [_chargeBtn.layer setCornerRadius:5];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    [btn setImage:[UIImage imageNamed:@"扫描充值卡"] forState:UIControlStateNormal];
    [btn setTitle:@"扫描充值卡" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    [btn addTarget:self action:@selector(pushToReward) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
}

- (void) pushToReward {
    
}

@end
