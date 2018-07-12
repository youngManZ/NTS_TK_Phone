//
//  PhoneViewController.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/1.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "PhoneViewController.h"
#import <NTS_TK_RecentProtocol.h>
#import <ProvideManager.h>
#import "NumCollectionViewCell.h"
#import "UIView+LXShadowPath.h"
#import "DottedLineView.h"
#import "ContactViewController.h"
#import "DetailContactVC.h"
#import "PhoneSetViewController.h"
#import <NTS_TK_Recent/RecentCallsViewController.h>

@interface PhoneViewController ()<SGPageContentScrollViewDelegate,SGPageTitleViewDelegate,ContactViewControllerDelegate>{
    NSArray *_titleArray;
    NSArray *_subTitleArray;
}

@property(nonatomic,strong) NSArray *vcsArray;
@property(nonatomic,strong) UIButton        *callBtn;
@property(nonatomic,strong) DottedLineView  *lineView;
@property(nonatomic,strong) SGPageContentScrollView *pageContentScrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHLayout;

@end

@implementation PhoneViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [(RecentCallsViewController *)[_vcsArray objectAtIndex:0] refreshVerHeadViewWithIsShow:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        if (self.numLabel.text.length > 0) {
            [self.numLabel setHidden:NO];
            [_pageTitleView setHidden:YES];
        }else {
            [self.numLabel setHidden:YES];
            [_pageTitleView setHidden:NO];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        [self.numLabel setHidden:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"粘贴",@"0",@"退格 (2)"];
    _subTitleArray = @[@"",@"ABC",@"DEF",@"GHI",@"JKL",@"MON",@"PQRS",@"TUV",@"WXYZ",@"粘贴",@"+",@""];
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.bottomSeparatorColor = [UIColor clearColor];
    configure.titleSelectedColor = [UIColor whiteColor];
    configure.indicatorColor = [UIColor whiteColor];
    _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(60, 0, [UIScreen mainScreen].bounds.size.width - 120, 40) delegate:self titleNames:@[@"通话记录",@"通讯录",@"通话设置"] configure:configure];
    [_pageTitleView setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.titleView = _pageTitleView;
    [self.navigationController.navigationBar addSubview:self.numLabel];
    
    id<NTS_TK_RecentProtocol> provide = [ProvideManager serviceProvideForProtocol:@protocol(NTS_TK_RecentProtocol)];
    UIViewController *vc1 = [provide recentCallsViewControllerWithUsername:@"18981204102"];
    ContactViewController *vc2 = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:[NSBundle mainBundle]];
    vc2.delegate = self;
    PhoneSetViewController *vc3 = [[PhoneSetViewController alloc] initWithNibName:@"PhoneSetViewController" bundle:[NSBundle mainBundle]];
//    vc3.delegate = self;
    _vcsArray = @[vc1,vc2,vc3];
    
    _pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44) parentVC:self childVCs:_vcsArray];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
    
    _collectionViewHLayout.constant = [UIScreen mainScreen].bounds.size.height * 0.5;
    [_collectionViewHLayout addObserver:self forKeyPath:@"constant" options:NSKeyValueObservingOptionNew context:nil];
    [_collectionView LX_SetShadowPathWith:[UIColor lightGrayColor] shadowOpacity:0.3 shadowRadius:2 shadowSide:LXShadowPathTop shadowPathWidth:4];
    [_collectionView registerNib:[UINib nibWithNibName:@"NumCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"numCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFooter"];
    [_collectionView addSubview:self.lineView];
    [self.view bringSubviewToFront:_collectionView];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark -- collection数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.0, ([UIScreen mainScreen].bounds.size.height / 2 - 80) / 4.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFooter" forIndexPath:indexPath];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    [footerView addSubview:self.callBtn];
    return footerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"numCell" forIndexPath:indexPath];
    
    [cell.iconView setHidden:YES];
    cell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.subTitleLabel.text = [_subTitleArray objectAtIndex:indexPath.row];
    if (indexPath.row == 9) {
        [cell setCopyImage:[UIImage imageNamed:[_titleArray objectAtIndex:indexPath.row]]];
    }else if (indexPath.row == 11){
        [cell setCenterImage:[UIImage imageNamed:[_titleArray objectAtIndex:indexPath.row]]];
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self numClickWithIndexPathRow:indexPath.row];
}

#pragma mark -- 输入盘的输入事件
- (void) numClickWithIndexPathRow : (NSInteger) row {
    if (row <= 8) {
        self.numLabel.text = [NSString stringWithFormat:@"%@%@",self.numLabel.text,[_titleArray objectAtIndex:row]];
    }else if (row == 9){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        if ([self isPureNumandCharacters:pasteboard.string]) {
            [self.numLabel setText:pasteboard.string];
        }
    }else if (row == 10){
        self.numLabel.text = [NSString stringWithFormat:@"%@%@",self.numLabel.text,[_titleArray objectAtIndex:row]];
    }else if (row == 11){
        if (self.numLabel.text.length > 0) {
            self.numLabel.text = [self.numLabel.text substringWithRange:NSMakeRange(0, self.numLabel.text.length - 1)];
        }
    }
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

#pragma mark -- kvo的代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"constant"]) {
        [UIView animateWithDuration:0.25 animations:^{
            [_pageContentScrollView setFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [change[@"new"] floatValue] - 44)];
        }];
    }else if ([keyPath isEqualToString:@"text"]){
        NSString *newStr = [NSString stringWithFormat:@"%@",change[@"new"]];
        [UIView animateWithDuration:0.2 animations:^{
            if (newStr.length > 0) {
                [self.numLabel setHidden:NO];
                [_pageContentScrollView setIsScrollEnabled:NO];
                [_pageTitleView setHidden:YES];
            }else {
                [self.numLabel setHidden:YES];
                [_pageContentScrollView setIsScrollEnabled:YES];
                [_pageTitleView setHidden:NO];
            }
        }];
    }
}

#pragma mark -- page页的代理
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [_pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex == 0) {
        _collectionViewHLayout.constant = [UIScreen mainScreen].bounds.size.height * 0.5;
    }else {
        _collectionViewHLayout.constant = 0;
    }
    if (_collectionViewHLayout.constant > 0) {
        [_collectionView setHidden:NO];
    }
    [UIView animateWithDuration: 0.25 animations: ^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (_collectionViewHLayout.constant > 0) {
            [_collectionView setHidden:NO];
        }else {
            [_collectionView setHidden:YES];
        }
    }];
    [_pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

#pragma mark -- ContactViewControllerDelegate
- (void)contactTableViewSelectPerson:(PPPersonModel *)person {
    DetailContactVC *vc = [[DetailContactVC alloc] initWithNibName:@"DetailContactVC" bundle:[NSBundle mainBundle]];
    vc.personModel = person;
    vc.block = ^(NSString *nameString, NSString *numString) {
        if ([_delegate respondsToSelector:@selector(callPhoneWithName:num:)]) {
            [_delegate callPhoneWithName:nameString num:numString];
        }
    };
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 懒加载
- (DottedLineView *)lineView {
    if (!_lineView) {
        _lineView = [[DottedLineView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2 - 80) verLineNum:2 horLineNum:4];
        [_lineView setUserInteractionEnabled:NO];
    }
    return _lineView;
}

- (UIButton *)callBtn {
    if (!_callBtn) {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callBtn setBounds:CGRectMake(0, 0, 60, 60)];
        [_callBtn setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 40)];
        [_callBtn setImage:[UIImage imageNamed:@"拨号 大"] forState:0];
    }
    return _callBtn;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        [_numLabel setBounds:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        [_numLabel setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 20)];
        [_numLabel setFont:[UIFont systemFontOfSize:24]];
        [_numLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [_numLabel setText:@""];
        [_numLabel setTextColor:[UIColor whiteColor]];
        [_numLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _numLabel;
}

@end
