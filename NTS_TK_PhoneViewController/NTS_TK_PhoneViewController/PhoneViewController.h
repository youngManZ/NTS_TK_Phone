//
//  PhoneViewController.h
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/1.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SGPagingView.h>

@protocol PhoneViewControllerDelegate <NSObject>

- (void) callPhoneWithName : (NSString *) name num : (NSString *) num;

@end

@interface PhoneViewController : UIViewController

@property(nonatomic,strong) SGPageTitleView *pageTitleView;
@property(nonatomic,strong) UILabel         *numLabel;
@property(nonatomic,assign) id<PhoneViewControllerDelegate> delegate;

@end
