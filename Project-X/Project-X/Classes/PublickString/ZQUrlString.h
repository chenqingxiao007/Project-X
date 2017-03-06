//
//  ZQUrlString.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/22.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQUrlString : NSObject
/**微博授权*/
extern NSString *const oauthUrl;
/**获取用户信息*/
extern NSString *const getUsers;
/**获取微博内容*/
extern NSString *const getFriensWeibo;
/**获取用户的粉丝数、关注数、微博数*/
extern NSString *const getUsersCount;
@end
