//
//  NumCollectionViewCell.h
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/4.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconCenterYLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWlayout;

- (void) setCenterImage : (UIImage *) centerImage;
- (void) setCopyImage : (UIImage *) copyImage;

@end
