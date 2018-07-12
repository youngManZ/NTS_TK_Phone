//
//  PhoneSetViewController.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/11.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "PhoneSetViewController.h"
#import "PhoneSetCell.h"
#import "QueryCallRecentVC.h"
#import "CardChargeVC.h"
#import "OpenMemberVC.h"

@interface PhoneSetViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_iconArray;
    NSArray *_titleArray;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLab;
@property (strong, nonatomic) IBOutlet UIButton *cerBtn;
@property (strong, nonatomic) IBOutlet UIButton *chargeBtn;
@property (strong, nonatomic) IBOutlet UILabel *balance;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation PhoneSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _iconArray = @[@"管理员",@"话单查询",@"充值卡充值",@"开通会员",@"归属地设置",@"说明 (5)"];
    _titleArray = @[@"管理员登录",@"话单查询",@"充值卡充值",@"开通会员",@"归属地设置",@"资费说明"];
    [_chargeBtn.layer setMasksToBounds:YES];
    [_chargeBtn.layer setCornerRadius:5];
    [_headView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110)];
    [_collectionView registerNib:[UINib nibWithNibName:@"PhoneSetCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"phoneSetCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
}

#pragma mark -- collection数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 3) / 3.0, ([UIScreen mainScreen].bounds.size.width - 3) / 3.0 - 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
    [header setBackgroundColor:[UIColor whiteColor]];
    [header addSubview:_headView];
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhoneSetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"phoneSetCell" forIndexPath:indexPath];
    [cell.icon setImage:[UIImage imageNamed:[_iconArray objectAtIndex:indexPath.row]]];
    [cell.title setText:[_titleArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            QueryCallRecentVC *vc = [[QueryCallRecentVC alloc] initWithNibName:@"QueryCallRecentVC" bundle:[NSBundle mainBundle]];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            CardChargeVC *vc = [[CardChargeVC alloc] initWithNibName:@"CardChargeVC" bundle:[NSBundle mainBundle]];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            OpenMemberVC *vc = [[OpenMemberVC alloc] initWithNibName:@"OpenMemberVC" bundle:[NSBundle mainBundle]];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
