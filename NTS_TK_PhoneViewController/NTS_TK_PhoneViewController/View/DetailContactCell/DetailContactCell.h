//
//  DetailContactCell.h
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/7.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailContactCellCallBlock)(NSIndexPath *selIndexPath);
@interface DetailContactCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (copy, nonatomic)   DetailContactCellCallBlock block;

@end
