//
//  AppDelegate.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AppDelegate.h"
#import "ElHomeTabBarController.h"
#import <QPLive/QPLive.h>
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudCrashReporting/AVOSCloudCrashReporting.h>
#import <LeanCloudSocial/LeanCloudSocial-umbrella.h>
#import "_User.h"
#import "ElLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    [[QPAuth shared] registerAppWithKey:kELAppKey secret:kELAppSecret space:@"com.kfc.ElephantLiving" success:^(NSString *accessToken) {
        NSLog(@"access token : %@", accessToken);
    } failure:^(NSError *error) {
        NSLog(@"failed : %@", error.description);
    }];
    // Override point for customization after application launch.
    
    // 登录注册
    [AVOSCloud setApplicationId:APP_ID clientKey:APP_KEY];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [AVOSCloud setAllLogsEnabled:YES];
    
    _User *user = [_User currentUser];
    if (user != nil) {
        ElHomeTabBarController *homeView = [[ElHomeTabBarController alloc] init];
        UINavigationController *navHomeView = [[UINavigationController alloc] initWithRootViewController:homeView];
        self.window.rootViewController = navHomeView;
    }else {
        ElLoginViewController *loginViewController = [[ElLoginViewController alloc] init];
        UINavigationController *navLoginVC = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        self.window.rootViewController = navLoginVC;
    }
    
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [AVOSCloudSNS handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [AVOSCloudSNS handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
