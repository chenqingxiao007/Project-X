//
//  ZQProfileController.m
//  Project-X
//
//  Created by ZQQ on 17/2/26.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQProfileController.h"

@interface ZQProfileController ()

@end

@implementation ZQProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏添加按钮
    [self NavAddButton];

}

- (void)NavAddButton{

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:my_nav_rightItem style:UIBarButtonItemStylePlain target:self action:@selector(setBtnClick)];
    rightBarItem.tintColor = [UIColor secondWordColor];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithTitle:my_nav_leftItem style:UIBarButtonItemStylePlain target:self action:@selector(addFriendBtnClick)];
    leftBarItem.tintColor = [UIColor secondWordColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
//点击设置
- (void)setBtnClick{
    NSLog(@"点击设置");
}
//点击添加好友
- (void)addFriendBtnClick{
    NSLog(@"点击添加好友");
}

@end
