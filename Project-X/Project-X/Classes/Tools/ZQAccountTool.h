//
//  ZQAccountTool.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/21.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQAccount.h"
@interface ZQAccountTool : NSObject
// 获得当前账号
@property (nonatomic, readonly) ZQAccount *account;

/**
 *  保存当前账号到沙盒
 *
 */
- (void)saveAccount:(ZQAccount *)account;


/**
 *  保存账号单例
 *
 */
+ (instancetype)shareAccountTool;

@end
