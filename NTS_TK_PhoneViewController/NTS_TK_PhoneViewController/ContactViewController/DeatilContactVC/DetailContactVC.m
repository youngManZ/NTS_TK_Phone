//
//  DetailContactVC.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/7.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "DetailContactVC.h"
#import "DetailContactCell.h"
#import "UIImage+CircleImage.h"
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>


#define IOS9 ([[UIDevice currentDevice] systemVersion].floatValue > 9.0 ? YES : NO )

@interface DetailContactVC ()<UITableViewDelegate,UITableViewDataSource,ABPersonViewControllerDelegate,CNContactViewControllerDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *contactHeadView;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation DetailContactVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [_nameLabel setText:_personModel.name];
    UIImage *image = _personModel.headerImage ? _personModel.headerImage : [UIImage imageNamed:@"个人中心 (7) 拷贝"];
    [_headImage setImage:[image drawCircleImageWithCornerRadius:20]];
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
    [_contactHeadView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.32)];
    [_tableView setTableHeaderView:_contactHeadView];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailContactCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"detailCell"];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _personModel.mobileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailContactCell" owner:nil options:nil] objectAtIndex:0];
        [cell setValue:@"detailCell" forKey:@"reuseIdentifier"];
    }
    NSString *num = [_personModel.mobileArray objectAtIndex:indexPath.row];
    [cell.numLabel setText:num];
    cell.indexPath = indexPath;
    cell.block = ^(NSIndexPath *selIndexPath) {
        if (_block) {
            _block(_personModel.name,[_personModel.mobileArray objectAtIndex:selIndexPath.row]);
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)action_backBtnClickEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)action_editBtnClickEvent:(id)sender {
    ABPersonViewController *personVC = [ABPersonViewController new];
    personVC.personViewDelegate = self;
    personVC.allowsEditing = YES;
    personVC.editing = YES;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancelEdit:)];
    personVC.navigationItem.leftBarButtonItem = leftItem;
    
    ABAddressBookRef abRef = ABAddressBookCreate();;
    personVC.displayedPerson = ABAddressBookGetPersonWithRecordID(abRef, (ABRecordID)_personModel.recordID);
    UINavigationController *subNav = [[UINavigationController alloc] initWithRootViewController:personVC];
    subNav.navigationBarHidden = NO;
    
    UINavigationBar *subNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width - 100, 44)];
    subNavBar.barStyle = UIBarStyleDefault;
    [subNavBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    subNavBar.shadowImage = [self createImageWithColor:[UIColor clearColor]];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@""];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancelEdit:)];
    navItem.leftBarButtonItem = backItem;
    
    subNavBar.items = [NSArray arrayWithObjects:navItem, nil];
    subNavBar.backgroundColor = [UIColor clearColor];
    [subNav.view addSubview:subNavBar];
    [self presentViewController:subNav animated:YES completion:nil];
}

- (void)cancelEdit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier;
{
    return YES;
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
