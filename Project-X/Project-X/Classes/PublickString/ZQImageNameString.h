//
//  ZQImageNameString.h
//  Project-X
//
//  Created by ZQQ on 17/2/22.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQImageNameString : NSObject

#pragma mark -- nav
//**返回按钮*/
extern NSString *const navigationbar_back_withtext;
extern NSString *const navigationbar_back_withtext_highlighted;//

#pragma mark -- tabBar icon
//**首页*/
extern NSString *const tabbar_home;
extern NSString *const tabbar_home_selected;
//**消息*/
extern NSString *const tabbar_message_center;
extern NSString *const tabbar_message_center_selected;
//**添加加号*/
extern NSString *const tabbar_compose_icon_add;
//**添加背景*/
extern NSString *const tabbar_compose_button;
extern NSString *const tabbar_compose_button_highlighted;
//**发现*/
extern NSString *const tabbar_discover;
extern NSString *const tabbar_discover_selected;
//**我*/
extern NSString *const tabbar_profile;
extern NSString *const tabbar_profile_selected;

#pragma mark -- my模块
//**新的好友*/
extern NSString *const my_friend;
//**我的相册*/
extern NSString *const my_album;
//**我的赞*/
extern NSString *const my_praise;
//**微博钱包*/
extern NSString *const my_purse;
//**微博运动*/
extern NSString *const my_sport;
//**粉丝服务*/
extern NSString *const my_fansServe;
//**粉丝头条*/
extern NSString *const my_fansTrend;
//**草稿箱*/
extern NSString *const my_draft;
//**更多*/
extern NSString *const my_more;

//**普通用户图标*/
extern NSString *const my_commonUser;
//**会员用户图标*/
extern NSString *const my_membership;

//**黄色箭头图标*/
extern NSString *const my_yellowarrow;
//**灰色箭头图标*/
extern NSString *const my_grayarrow;

@end
