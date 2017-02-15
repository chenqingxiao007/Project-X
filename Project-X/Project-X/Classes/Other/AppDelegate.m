//
//  AppDelegate.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/6.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "AppDelegate.h"
#import "ZQLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //注册微博appkey
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kWBAppKey];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ZQLoginViewController *oauth = [[ZQLoginViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:oauth];
    [self setupNavBar];
    

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
#pragma mark - setupNavBar
- (void)setupNavBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor redColor];//导航栏颜色
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};//导航栏字体颜色
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
    {
        return [WeiboSDK handleOpenURL:url delegate:self ];
    }
@end