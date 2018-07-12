//
//  ContactTableViewCell.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/6.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "UIImage+CircleImage.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSystemServiceWithName:(NSString *)name phone:(NSString *)phone {
    [_headImage setImage:[UIImage imageNamed:@"系统客服"]];
    _titleLabel.text = name;
    _subTitleLabel.text = phone;
}

- (void)setPerson:(PPPersonModel *)person {
    _person = person;
    UIImage *image = person.headerImage ? person.headerImage : [UIImage imageNamed:@"联系人默认头像"];
    [_headImage setImage:[image drawCircleImageWithCornerRadius:20]];
    _titleLabel.text = person.name;
    if (person.mobileArray.count > 0) {
        _subTitleLabel.text = [person.mobileArray objectAtIndex:0];
    }
    if (person.address.length > 0) {
        _subTitleLabel.text = [NSString stringWithFormat:@"%@ |%@",_subTitleLabel.text,person.address];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
