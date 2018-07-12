//
//  DetailContactVC.h
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/7.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPersonModel.h"

typedef void(^DetailContactVCBlock)(NSString *nameString,NSString *numString);

@interface DetailContactVC : UIViewController

@property(nonatomic,strong) PPPersonModel       *personModel;
@property(nonatomic,copy)   DetailContactVCBlock block;

@end
