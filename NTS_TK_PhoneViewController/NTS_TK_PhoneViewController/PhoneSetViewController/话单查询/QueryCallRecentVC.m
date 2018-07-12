//
//  QueryCallRecentVC.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/7/11.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "QueryCallRecentVC.h"
#import <PGDatePicker.h>
#import <PGDatePickManager.h>
#import "QueryCallRecentCell.h"

@interface QueryCallRecentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PGDatePickerDelegate>{
    NSMutableArray  *_dataArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITextField *dayText;
@property (strong, nonatomic) IBOutlet UIButton *queryBtn;

@end

@implementation QueryCallRecentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"话单查询";
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@""]];
    [_queryBtn.layer setMasksToBounds:YES];
    [_queryBtn.layer setCornerRadius:5];
    [_headView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110)];
    [_headView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [_tableview setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [_tableview setTableHeaderView:_headView];
    [_tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
    [_footerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 160)];
    [_tableview setBackgroundView:_footerView];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableview registerNib:[UINib nibWithNibName:@"QueryCallRecentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"callRecentCell"];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count == 0) {
        [_footerView setHidden:NO];
    }else {
        [_footerView setHidden:YES];
    }
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QueryCallRecentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"callRecentCell"];
    if (cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QueryCallRecentCell" owner:nil options:nil] objectAtIndex:0];
    }
    [cell setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    
    return cell;
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGPickerViewType1;
    datePicker.isHiddenMiddleText = false;
    datePicker.isHiddenWheels = false;
    datePicker.maximumDate = [NSDate date];
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
    return NO;
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString * str = [formatter stringFromDate:date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    [_dayText setText:str];
    NSLog(@"时间格式---->%@---->时间戳%@",str,timeSp);
}

@end
