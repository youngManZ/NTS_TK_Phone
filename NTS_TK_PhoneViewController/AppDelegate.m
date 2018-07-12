//
//  AppDelegate.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/1.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "AppDelegate.h"
#import "PhoneViewController.h"
#import <NTS_TK_Recent/RecentTool.h>
#import <NTS_TK_Recent/RecentCallObject.h>
#import "YYFPSLabel.h"

@interface AppDelegate ()

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 判断数据库的创建
    [RecentTool createDatabaseDirectoryWithUsername:@"18981204102"];
    /*
    // 测试添加通话记录
    for (int i = 0; i < 5; i++) {
        RecentCallObject *object = [[RecentCallObject alloc] init];
        object.callName = [NSString stringWithFormat:@"测试数据%d",i];
        object.callNumber = [NSString stringWithFormat:@"%ld",18981204102 + i];
        object.callDate = [NSDate date];
        object.callFinalData = [NSDate date];
        object.callId = [NSNumber numberWithInt:i];
        sqlite3 *database;
        NSString *documentsDirectory = [RecentTool defaultUserDataPathWithUsername:@"18981204102"];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"user.sql"];
        if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
        {
            [object changeDataBase:database username:@"18981204102"];
        }
        NSArray *resultArray = [object readThisIdRecentCountArrayWithUsername:@"18981204102"];
        NSLog(@"----->条数%lu",(unsigned long)resultArray.count);
    }
     */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    PhoneViewController *root = [[PhoneViewController alloc] initWithNibName:@"PhoneViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    
    [_window setRootViewController:nav];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:95/255.0 alpha:1];
    navBar.tintColor = [UIColor whiteColor];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    
    [self.window makeKeyAndVisible];
    
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 30, 50, 20);
    [_fpsLabel sizeToFit];
    [_window addSubview:_fpsLabel];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
