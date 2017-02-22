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
#import "ZQUserMessage.h"

@interface ZQHomeController ()

@end

@implementation ZQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self getUsers];
    
}

- (void)getUsers{
    ZQAccount *account = [ZQAccountTool shareAccountTool].account;
    if (account) {
        NSDictionary *paramenters = @{@"access_token":account.access_token,
                                      @"uid":account.uid};
        [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypeGet url:getUsers params:paramenters success:^(id responseObject) {
            //
            NSLog(@"responseObject%@",responseObject);
            ZQUserMessage *userMessage = [ZQUserMessage mj_objectWithKeyValues:responseObject];
            NSLog(@"userMessage%@",userMessage.WBdescription);
            NSLog(@"%@",userMessage.screen_name);
        } failure:^(NSError *error) {
            //
            NSLog(@"失败了");
        }];
        
    }
    
}



@end
