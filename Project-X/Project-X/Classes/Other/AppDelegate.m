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
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //注册微博appkey
    [self setJSPatch];
    [self setupWeibo];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CQAlert *alert = [[CQAlert alloc] init];
//        [alert showAlertWithString:@"哈哈哈"];
//    });
   
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
        ZQUserMessage *getuserMessage =   [NSKeyedUnarchiver unarchiveObjectWithData:getuserMessageData];
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

- (void)setJSPatch {
    
    [JSPatch startWithAppKey:kJSPatchAppKey];
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0MxTcJmVsLZsrG5J87YmLNga0\n/QVE1qcCGYOjzOUq7U4p8tXCysHtP7Evmu9p/rhlRhMLBKeJyPnz3zh7jaJR0dcG\nNLa6Dr1YET8Mdz2rq7+9IoPu2WoGNpVvllu14CTlT2Pat2b5D5BhrWtT8BwOiwdU\nTvZwCJb1eWYWB52NiwIDAQAB\n-----END PUBLIC KEY-----"];
    [JSPatch sync];

}

- (void)setupWeibo{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kWBAppKey];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        ZQAccount *account = [ZQAccount accountWithDic:response.userInfo];
        [[ZQAccountTool shareAccountTool] saveAccount:account];
        [ZQNetWorkHelper getUsers];
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        [(ZQLoginViewController *)nav.childViewControllers[0] changeRootVC];
        
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
