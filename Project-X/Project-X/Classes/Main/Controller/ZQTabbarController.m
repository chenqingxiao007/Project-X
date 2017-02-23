//
//  ZQTabbarController.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/7.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQTabbarController.h"
//宏
#define kClassKey @"rootVCClassString"
#define kTitleKey @"title"
#define kImgKey @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface ZQTabbarController ()

@end

@implementation ZQTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *childItemsArray = @[
                                 @{kClassKey:@"ZQHomeController",
                                   kTitleKey:@"首页",
                                   kImgKey:tabbar_home,
                                   kSelImgKey:tabbar_home_selected},
                                 @{kClassKey:@"ZQMessageController",
                                   kTitleKey:@"消息",
                                   kImgKey:tabbar_message_center,
                                   kSelImgKey:tabbar_message_center_selected},
                                 @{kClassKey:@"ZQAddController",
                                   kTitleKey:@"添加",
                                   kImgKey:@"",
                                   kSelImgKey:@""},
                                 @{kClassKey:@"ZQDiscoverController",
                                   kTitleKey:@"发现",
                                   kImgKey:tabbar_discover,
                                   kSelImgKey:tabbar_discover_selected},
                                 @{
                                   kClassKey:@"ZQMyController",
                                   kTitleKey:@"我的",
                                   kImgKey:tabbar_profile,
                                   kSelImgKey:tabbar_profile_selected}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop){
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//去除蒙版
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor]} forState:UIControlStateSelected];//选中颜色

        [self addChildViewController:nav];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
