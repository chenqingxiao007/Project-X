
//
//  ZQMyController.m
//  Project-X
//
//  Created by ZQQ on 17/2/9.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyController.h"
#import "ZQCellModel.h"

@interface ZQMyController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
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
                             @"introduce":@""
                             }],
                       @[@{
                             @"title":@"粉丝服务",
                             @"icon":my_fansServe,
                             @"introduce":@""
                             },
                         @{
                             @"title":@"粉丝头条",
                             @"icon":my_fansTrend,
                             @"introduce":@""
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
                               @"introduce":@""
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
    static NSString *cellId = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;//箭头
    }
    NSDictionary *dict = self.dataArray[indexPath.section][indexPath.row];
    ZQCellModel *cellModel = [ZQCellModel mj_objectWithKeyValues:dict];
    cell.textLabel.text = cellModel.title;
    cell.imageView.image = [UIImage imageNamed:cellModel.icon];
    cell.detailTextLabel.text = cellModel.introduce;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}


@end
