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

@interface ZQHomeController ()

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}

- (void)buildUI {
    
    self.title = UserMessage.screen_name;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - getter and setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
