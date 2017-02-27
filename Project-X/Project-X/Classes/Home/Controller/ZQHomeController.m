//
//  ZQHomeController.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/7.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQHomeController.h"
#import "ZQAccount.h"
#import "ZQAccountTool.h"
#import "ZQNetWorkHelper.h"
#import "ZQHomeModel.h"
#import "ZQWeiboCell.h"

@interface ZQHomeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listData;

@end

@implementation ZQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self getWeibo];
}

- (void)buildUI {
    
    self.navigationItem.title = UserMessage.screen_name;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)refresh:(id)sender{
    NSLog(@"%@",@"我在下拉刷新");
    [self getNewWeibo];
}

- (void)getWeibo {
    
    
    NSDictionary *paramenters = @{@"access_token":Acount.access_token};

    [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypeGet url:getFriensWeibo params:paramenters success:^(id responseObject) {
        ZQHomeModel *homeModel = [[ZQHomeModel alloc] initWithDict:responseObject];
        
        self.listData = homeModel.weiboModels;
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getNewWeibo {
    
    ZQWeiboModel *newModel = self.listData.firstObject;

    NSDictionary *paramenters = @{@"access_token":Acount.access_token,@"since_id":newModel.weibo_id};
    
    [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypeGet url:getFriensWeibo params:paramenters success:^(id responseObject) {
        ZQHomeModel *homeModel = [[ZQHomeModel alloc] initWithDict:responseObject];
        
        
        if (homeModel.weiboModels.count > 0) {
            [self.listData insertObjects:[homeModel.weiboModels copy] atIndexes:[NSIndexSet indexSetWithIndex:0]];
        }
        
        [self.tableView reloadData];
        [self.tableView.refreshControl endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.refreshControl endRefreshing];
    }];

}

#pragma mark - delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifer = @"reuseCell";
    ZQWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[ZQWeiboCell alloc] init];
    }
    ZQWeiboModel *weiboModel = self.listData[indexPath.row];
    cell.weiboModel = weiboModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}


#pragma mark - getter and setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        _tableView.refreshControl = refreshControl;
    }
    return _tableView;
}



@end
