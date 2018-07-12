//
//  ContactViewController.h
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/6.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPersonModel.h"

@protocol ContactViewControllerDelegate <NSObject>

- (void)contactTableViewSelectPerson : (PPPersonModel *) person;

@end

@interface ContactViewController : UIViewController

@property(nonatomic,assign) id<ContactViewControllerDelegate> delegate;

@end
