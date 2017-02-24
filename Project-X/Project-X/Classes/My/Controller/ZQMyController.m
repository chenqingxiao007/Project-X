
//
//  ZQMyController.m
//  Project-X
//
//  Created by ZQQ on 17/2/9.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyController.h"
#import "ZQCellModel.h"
#import "ZQMyHeaderCell.h"
#import "ZQMyCell.h"
@interface ZQMyController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *cell;

@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ZQMyController

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        //数组嵌套数组 嵌套再字典
        _dataArray = @[
                       @[@{
                             @"title":@"",
                             @"icon":@"",
                             @"introduce":@""
                             }],
                       @[@{
                             @"title":@"新的好友",
                             @"icon":my_friend,
                             @"introduce":@""
                             }],
                       @[@{
                             @"title":@"我的相册",
                             @"icon":my_album,
                             @"introduce":@""
                             },
                         @{
                             @"title":@"我的赞",
                             @"icon":my_praise,
                             @"introduce":@""
                             }],
                       @[@{
                             @"title":@"微博钱包",
                             @"icon":my_purse,
                             @"introduce":@"白拿5000元旅游基金"
                             },
                        @{
                             @"title":@"微博运动",
                             @"icon":my_sport,
                             @"introduce":@"每天10000步，你达标了吗？"
                             }],
                       @[@{
                             @"title":@"粉丝服务",
                             @"icon":my_fansServe,
                             @"introduce":@"写文章、发评论、转粉丝"
                             },
                         @{
                             @"title":@"粉丝头条",
                             @"icon":my_fansTrend,
                             @"introduce":@"推广博文及账号的利器"
                             }],

                       @[@{
                             @"title":@"草稿箱",
                             @"icon":my_draft,
                             @"introduce":@""
                             }],
                       @[
                           @{
                               @"title":@"更多",
                               @"icon":my_more,
                               @"introduce":@"收藏"
                               }]
                               ];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏添加按钮
    [self NavAddButton];
    //添加tableView
    [self setupTableView];
    //设置我的页面cell数据
    NSLog(@"userMessage%@",UserMessage.profile_image_url);
    NSLog(@"userMessage%ld",(long)UserMessage.verified);
    NSLog(@"userMessage%@",UserMessage.WBdescription);
    NSLog(@"userMessage%ld",(long)UserMessage.friends_count);


}
- (void)NavAddButton{

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendBtnClick)];
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

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
}


#pragma mark - tableView数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZQMyHeaderCell *cell = [ZQMyHeaderCell cellWithTableView:tableView];
        cell.userMessage = UserMessage;
        self.cell = cell;
    }else{

        NSDictionary *dict = self.dataArray[indexPath.section][indexPath.row];
        ZQCellModel *cellModel = [ZQCellModel mj_objectWithKeyValues:dict];
        ZQMyCell *cell = [ZQMyCell cellWithTableView:tableView];
        cell.cellModel = cellModel;
        self.cell = cell;
    }
    return self.cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140;
    }else{
        return 50;
    }
}
@end
