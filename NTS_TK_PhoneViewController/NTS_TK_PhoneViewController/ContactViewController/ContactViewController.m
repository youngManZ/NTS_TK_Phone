//
//  ContactViewController.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/6.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "ContactViewController.h"
#import "PPGetAddressBook.h"
#import "PPAddressBookHandle.h"
#import "ContactTableViewCell.h"

@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    BOOL    _isSearchActive;
}

@property (strong, nonatomic) UIView               *leftView;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray              *keyArray;
@property (strong, nonatomic) NSDictionary<NSString *,NSArray *> *personDict;
@property (strong, nonatomic) NSMutableArray       *searchArray;
@property (strong, nonatomic) NSArray              *allContactArray;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取通讯类信息
    _isSearchActive = NO;
    _keyArray = [[NSArray alloc] init];
    _personDict = [[NSDictionary alloc] init];
    _searchArray = [[NSMutableArray alloc] init];
    [[PPAddressBookHandle sharedAddressBookHandle] requestAuthorizationWithSuccessBlock:^{
        [PPGetAddressBook getAllAddressBook:^(NSArray<PPPersonModel *> *addressBookArray, NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
            _keyArray = [nameKeys copy];
            _personDict = [addressBookDict copy];
            _allContactArray = [addressBookArray copy];
            [_tableView reloadData];
        } authorizationFailure:^{
            
        }];
    }];
    
    // 初始化ui
    [_searchText.layer setMasksToBounds:YES];
    [_searchText.layer setCornerRadius:5];
    [_searchText setLeftViewMode:UITextFieldViewModeAlways];
    [_searchText setLeftView:self.leftView];
    [_searchText addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    [_searchView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ContactCell"];
}

#pragma mark -- tableview的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSearchActive)  return 1;
    return _keyArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearchActive) return _searchArray.count;
    if (section == 0)  return 1;
    NSString *key = [_keyArray objectAtIndex:(section - 1)];
    if ([[_personDict allKeys]containsObject:key]) {
        NSArray *array = [_personDict objectForKey:key];
        return array.count;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_isSearchActive) return 0;
    if (section == 0) return 0;
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 35)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 5)];
    [lineView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [headView addSubview:lineView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 10, [UIScreen mainScreen].bounds.size.width - 60, 20)];
    [titleLabel setText:[_keyArray objectAtIndex:(section - 1)]];
    [titleLabel setFont:[UIFont systemFontOfSize:18]];
    [headView addSubview:titleLabel];
    return headView;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearchActive) return @[];
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"*", nil];
    [array addObjectsFromArray:_keyArray];
    return array;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactTableViewCell" owner:nil options:nil] objectAtIndex:0];
        [cell setValue:@"ContactCell" forKey:@"reuseIdentifier"];
    }
    if (!_isSearchActive) {
        if (indexPath.section == 0) {
            [cell setSystemServiceWithName:@"系统客服" phone:@"10086"];
        }else {
            NSString *key = _keyArray[(indexPath.section - 1)];
            PPPersonModel *people = [_personDict[key] objectAtIndex:indexPath.row];
            [cell setPerson:people];
        }
    }else {
        PPPersonModel *people = [_searchArray objectAtIndex:indexPath.row];
        [cell setPerson:people];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *showCell = (ContactTableViewCell *)cell;
    if (!_isSearchActive) {
        if (indexPath.section == 0) {
            [showCell setSystemServiceWithName:@"系统客服" phone:@"10086"];
        }else {
            NSString *key = _keyArray[(indexPath.section - 1)];
            PPPersonModel *people = [_personDict[key] objectAtIndex:indexPath.row];
            if (people.address.length > 0) {
                return;
            }
            [people getAddressWithBlock:^(NSString *address) {
                [showCell setPerson:people];
            }];
        }
    }else {
        PPPersonModel *people = [_searchArray objectAtIndex:indexPath.row];
        if (people.address.length > 0) {
            return;
        }
        [people getAddressWithBlock:^(NSString *address) {
            [showCell setPerson:people];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PPPersonModel *people = nil;
    if (!_isSearchActive) {
        if (indexPath.section == 0) {
            return;
        }else {
            NSString *key = _keyArray[(indexPath.section - 1)];
            people = [_personDict[key] objectAtIndex:indexPath.row];
        }
    }else {
        people = [_searchArray objectAtIndex:indexPath.row];
    }
    if ([_delegate respondsToSelector:@selector(contactTableViewSelectPerson:)]) {
        [_delegate contactTableViewSelectPerson:people];
    }
}

#pragma mark -- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text.length > 0) {
        [self startSearch];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self endSearch];
}

- (void)textFieldDidChangeValue:(id)sender
{
    if (_searchText.text.length > 0) {
        [self startSearch];
    }else {
        [self endSearch];
    }
}

- (void) startSearch {
    [_searchArray removeAllObjects];
    [_searchArray addObjectsFromArray:[self filterContentForSearchText:_searchText]];
    _isSearchActive = YES;
    [_tableView reloadData];
}

- (void) endSearch {
    [_searchArray removeAllObjects];
    _isSearchActive = NO;
    [_tableView reloadData];
}

- (NSArray *)filterContentForSearchText:(UITextField *)searchText
{
    NSMutableArray * searchesArray = [[NSMutableArray alloc] init];
    if ([searchText.text isEqualToString:@""]) {
//        [searchesArray addObjectsFromArray:_allContactArray];
    }else {
        for (int i = 0; i < _allContactArray.count; i++) {
            PPPersonModel *person = [_allContactArray objectAtIndex:i];
            NSComparisonResult result = NSOrderedAscending;
            NSComparisonResult result1 = NSOrderedAscending;
            NSComparisonResult result2 = NSOrderedAscending;
            if ([person.name isEqualToString:searchText.text]) {
                result = NSOrderedSame;
            }
            if ([person.namePinYin containsString:searchText.text]|| [person.name containsString:searchText.text]) {
                result1 = NSOrderedSame;
            }
            for (NSString *num in person.mobileArray) {
                if ([num containsString:searchText.text]) {
                    result2 = NSOrderedSame;
                    break;
                }
            }
            if (result == NSOrderedSame || result1 == NSOrderedSame || result2 == NSOrderedSame){
                [searchesArray addObject:person];
            }
        }
    }
    return searchesArray;
}

#pragma mark -- 懒加载
- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
        [searchImage setImage:[UIImage imageNamed:@"搜索icon"]];
        [_leftView addSubview:searchImage];
    }
    return _leftView;
}

@end
