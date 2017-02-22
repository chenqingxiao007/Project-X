
//
//  ZQMyController.m
//  Project-X
//
//  Created by ZQQ on 17/2/9.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyController.h"
#import "ZQAccountTool.h"
@interface ZQMyController ()

@end

@implementation ZQMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏添加按钮
    [self NavAddButton];
}
- (void)NavAddButton{

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setBtnClick)];

    self.navigationItem.rightBarButtonItem = rightBarItem;
}
//点击设置
- (void)setBtnClick{
    NSLog(@"点击设置");
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
