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

@interface ZQHomeController ()

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
    
    self.title = UserMessage.screen_name;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
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
#pragma mark - getter and setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
