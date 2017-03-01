
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
#import "ZQProfileController.h"
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
                             @"title":my_cell_firstTitle,
                             @"icon":my_friend,
                             @"introduce":my_cell_firstIntroduce
                             }],
                       @[@{
                             @"title":my_cell_secondTitle,
                             @"icon":my_album,
                             @"introduce":my_cell_secondIntroduce
                             },
                         @{
                             @"title":my_cell_thirdTitle,
                             @"icon":my_praise,
                             @"introduce":my_cell_thirdIntroduce
                             }],
                       @[@{
                             @"title":my_cell_fourthTitle,
                             @"icon":my_purse,
                             @"introduce":my_cell_fourthIntroduce
                             },
                        @{
                             @"title":my_cell_fifthTitle,
                             @"icon":my_sport,
                             @"introduce":my_cell_fifthIntroduce
                             }],
                       @[@{
                             @"title":my_cell_sixthTitle,
                             @"icon":my_fansServe,
                             @"introduce":my_cell_sixthIntroduce
                             },
                         @{
                             @"title":my_cell_sevenTitle,
                             @"icon":my_fansTrend,
                             @"introduce":my_cell_sevenIntroduce
                             }],

                       @[@{
                             @"title":my_cell_eightTitle,
                             @"icon":my_draft,
                             @"introduce":my_cell_eightIntroduce
                             }],
                       @[
                           @{
                               @"title":my_cell_nineTitle,
                               @"icon":my_more,
                               @"introduce":my_cell_nineIntroduce
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

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
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
        cell.ImageCliclBlock = ^{
            NSLog(@"点击图片");
            ZQProfileController *vc = [[ZQProfileController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.button_statuses.HeaderBtnBlock = ^{
            NSLog(@"点击微博");
        };
        cell.button_followers.HeaderBtnBlock = ^{
            NSLog(@"点击粉丝");
        };
        cell.button_friends.HeaderBtnBlock = ^{
            NSLog(@"点击关注");
        };
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
