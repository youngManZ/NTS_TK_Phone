//
//  OpenMemberVC.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/7/12.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "OpenMemberVC.h"

@interface OpenMemberVC ()

@property (strong, nonatomic) IBOutlet UIView *openView;

@end

@implementation OpenMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开通会员";
    [_openView.layer setMasksToBounds:YES];
    [_openView.layer setCornerRadius:5];
}

@end
