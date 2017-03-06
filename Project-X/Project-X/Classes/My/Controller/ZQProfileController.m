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
@interface ZQProfileController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//**用来显示用户名的导航栏，只有当分页栏定在顶部时，才显示*/
@property (nonatomic, weak) UIView *navigationView;
@property (nonatomic, strong) ZQProfileHeaderView *headerView;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *searchBtn;

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
    [self.moreBtn removeFromSuperview];
    [self.searchBtn removeFromSuperview];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setUpTableView];
    [self setupNavigationView];
    [self.view addSubview:self.headerView];

}
- (void)setUpTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight - 64, 0, 0, 0);

}
- (void)setupNavigationView
{
    //添加两个按钮到window
    UIButton *moreBtn = [[UIButton alloc]init];
    self.moreBtn = moreBtn;
    [moreBtn setBackgroundImage:[UIImage imageNamed:navigationbar_more_light] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].windows.lastObject addSubview:moreBtn];
    moreBtn.frame = CGRectMake(SCREEN_WIDTH-32, 31, 22,22);

    //添加两个按钮到window
    UIButton *searchBtn = [[UIButton alloc]init];
    self.searchBtn = searchBtn;
    [searchBtn setBackgroundImage:[UIImage imageNamed:navigationbar_search_dark] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].windows.lastObject addSubview:searchBtn];
    searchBtn.frame = CGRectMake(SCREEN_WIDTH-71, 31, 22,22);
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navigationView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, 20)];
    titleLabel.text = UserMessage.screen_name;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:titleLabel];
    navigationView.alpha = 0;
//   添加底部黑线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor separateLineViewColor];
    [navigationView addSubview:lineView];
    [self.view addSubview:navigationView];
    self.navigationView = navigationView;
}
- (void)moreBtnClick{
    NSLog(@"点击更多按钮");
}
- (void)searchBtnClick{
    NSLog(@"点击搜索按钮");

}
#pragma mark getter
- (ZQProfileHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[ZQProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderHeight)];
        
        _headerView.segmentView = [[LiuXSegmentView alloc]initWithFrame:CGRectMake(0, kHeaderHeight - kHeaderSegmentHeight, SCREEN_WIDTH, kHeaderSegmentHeight) titles:@[@"",my_profile_home,my_profile_statuses,my_profile_album,@""]  clickBlick:^(NSInteger index) {
            //点击事件 index从1开始 234对应主页微博相册
            NSLog(@"-----%ld",index);
            if (index == 3);
        }];
        [_headerView addSubview:_headerView.segmentView];
        _headerView.userMessage = UserMessage;
    }
    return _headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;//偏移的y

    NSLog(@"...... %f",offsetY);

    if (offsetY == 0) {
        return;
    }
    if (offsetY < 0) {
        //下拉
        CGFloat scale = 1.0;
        scale = MIN(1.1, 1 - offsetY / 200);
        self.headerView.bgImageView.transform = CGAffineTransformMakeScale(scale, scale);

        if (offsetY == -64) {
            return;
        }
        self.headerView.frame = CGRectMake(0, -offsetY, SCREEN_WIDTH, kHeaderHeight);
    }
    if (offsetY > 0) {
        //处理图片

        if (offsetY>72 && offsetY<118) {
            //显示导航栏
            self.navigationView.alpha = (offsetY-72)/64;
            [self.view bringSubviewToFront:self.navigationView];
        }if (offsetY >= 118) {
            //固定headViewFrame
            self.navigationView.alpha = 1;
            self.navigationController.navigationBar.tintColor = [UIColor grayColor];
            [self.searchBtn setBackgroundImage:[UIImage imageNamed:navigationbar_search] forState:UIControlStateNormal];
            [self.moreBtn setBackgroundImage:[UIImage imageNamed:navigationbar_more] forState:UIControlStateNormal];
            self.headerView.frame = CGRectMake(0, -118, SCREEN_WIDTH, kHeaderHeight);
        }else{
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self.searchBtn setBackgroundImage:[UIImage imageNamed:navigationbar_search_dark] forState:UIControlStateNormal];
            [self.moreBtn setBackgroundImage:[UIImage imageNamed:navigationbar_more_light] forState:UIControlStateNormal];
            //0-72
            if (offsetY>8) {
                self.navigationView.alpha = (offsetY-72)/64;

            }else{
                self.navigationView.alpha = 0;

            }
            self.headerView.frame = CGRectMake(0, -offsetY, SCREEN_WIDTH, kHeaderHeight);
        }
    }
}

//点击相册
- (void)alumBtnClick{
}
@end
