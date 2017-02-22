//
//  ZQUserMessage.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/22.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ZQUserMessage : NSObject
//**头像地址*/
@property (nonatomic, copy) NSString *profile_image_url;

//**用户昵称*/
@property (nonatomic, copy) NSString *screen_name;

//**是否是微博认证用户*/
@property (nonatomic, assign) NSInteger verified;

//**自我描述*/
@property (nonatomic, copy) NSString *WBdescription;

//**微博数*/
@property (nonatomic, assign) NSInteger favourites_count;

//**关注数*/
@property (nonatomic, assign) NSInteger friends_count;

//**粉丝数*/
@property (nonatomic, assign) NSInteger followers_count;


@end
