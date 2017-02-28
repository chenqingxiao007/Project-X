//
//  ZQProfileController.m
//  Project-X
//
//  Created by ZQQ on 17/2/26.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQProfileController.h"
#import "ZQProfileHeaderView.h"
#import "LiuXSegmentView.h"
@interface ZQProfileController ()
@property (nonatomic, strong) UITableView *tableView;
//**用来显示用户名的导航栏，只有当分页栏定在顶部时，才显示*/
@property (nonatomic, weak) UIView *navigationView;
@property (nonatomic, strong) ZQProfileHeaderView *headerView;
@end

@implementation ZQProfileController
//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏背景为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    // 隐藏导航栏底部黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
//
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 当都设置为nil的时候，导航栏会使用默认的样式，即还原导航栏样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupNavigationView];
    [self.view addSubview:self.headerView];

}

- (void)setupNavigationView
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navigationView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, 20)];
    titleLabel.text = UserMessage.screen_name;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:titleLabel];
    
    navigationView.alpha = 0;
    [self.view addSubview:navigationView];
    self.navigationView = navigationView;
}
#pragma mark getter
- (ZQProfileHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[ZQProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderHeight)];
        
        _headerView.segmentView = [[LiuXSegmentView alloc]initWithFrame:CGRectMake(0, kHeaderHeight - kHeaderSegmentHeight, SCREEN_WIDTH, kHeaderSegmentHeight) titles:@[@"",my_profile_home,my_profile_favourites,my_profile_album,@""]  clickBlick:^(NSInteger index) {
            //点击事件 index从1开始 234对应主页微博相册
            NSLog(@"-----%ld",index);
        }];
        [_headerView addSubview:_headerView.segmentView];
        _headerView.userMessage = UserMessage;
    }
    return _headerView;
}
@end
