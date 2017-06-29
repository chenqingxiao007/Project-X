//
//  AppDelegate.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/6.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "AppDelegate.h"
#import "ZQLoginViewController.h"
#import "ZQTabbarController.h"
#import "ZQNetWorkHelper.h"
#import "JPUSHService.h"
#import <JSPatchPlatform/JSPatch.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setJSPatch];
    //注册微博appkey
    [self setWeibo];
    [self setJPushWithOption:launchOptions];
    
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //设置控制器为Window的根控制器
    if(Acount){
        // 用户已经授权过
        ZQTabbarController *tabBarVC = [[ZQTabbarController alloc] init];
        self.window.rootViewController = tabBarVC;
        
        //获得保存数据
        NSData *getuserMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"theuserMessage"];
        //转成模型获取数据
        ZQUserMessage *getuserMessage = [NSKeyedUnarchiver unarchiveObjectWithData:getuserMessageData];
        UserMessage = getuserMessage;

    }else{
        // 未授权加载授权页面
        ZQLoginViewController *loginVC = [[ZQLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        self.window.rootViewController = nav;
    }
    [self setupNavBar];
    return YES;
}

- (void)setJPushWithOption:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey channel:@"AppStore" apsForProduction:NO advertisingIdentifier:nil];
    
}

- (void)setJSPatch {
    [JSPatch startWithAppKey:kJSPatchAppKey];
    [JSPatch setupRSAPublicKey:kJSPatchAppPublicKey];
    [JSPatch sync];
}

- (void)setWeibo{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kWBAppKey];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        ZQAccount *account = [ZQAccount accountWithDic:response.userInfo];
        [[ZQAccountTool shareAccountTool] saveAccount:account];
        [ZQNetWorkHelper getUsers];
        
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *rootViewController = appdelegate.window.rootViewController;
        
        [rootViewController.childViewControllers[0] changeRootVC];
        
    }
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

#pragma mark - 极光方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void) jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
    
}

- (void) jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
}

#pragma mark - setupNavBar
- (void)setupNavBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor firstWordColor];
        
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
