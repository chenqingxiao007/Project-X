//
//  ZQBaseViewController.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/27.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQBaseViewController.h"

@interface ZQBaseViewController ()

@end

@implementation ZQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.tabBar setHidden:YES];
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
