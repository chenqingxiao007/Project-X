//
//  ZQAccount.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/21.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQAccount : NSObject

/**
 *  accessToken
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  授权过期时间
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *   授权过期提醒时间
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  创建账号
 *
 *  @param dic 账号信息字典
 *
 */
+ (instancetype)accountWithDic:(NSDictionary *)dic;
@end
