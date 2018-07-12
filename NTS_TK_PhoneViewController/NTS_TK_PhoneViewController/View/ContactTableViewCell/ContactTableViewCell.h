//
//  ContactTableViewCell.h
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/6.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGetAddressBook.h"

@interface ContactTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;

@property(nonatomic,strong) PPPersonModel   *person;

- (void) setSystemServiceWithName : (NSString *) name phone : (NSString *) phone;

@end
