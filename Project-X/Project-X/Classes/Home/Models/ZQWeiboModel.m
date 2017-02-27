//
//  ZQWeiboModel.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/27.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQWeiboModel.h"

@implementation ZQWeiboModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        NSDictionary *userInfoDic = [dic valueForKey:@"user"];
        
        self.profile_image_url = [userInfoDic valueForKey:@"profile_image_url"];
        self.screen_name = [userInfoDic valueForKey:@"screen_name"];
        self.text = [dic valueForKey:@"text"];
        self.thumbnail_pic = [dic valueForKey:@"thumbnail_pic"];
        self.pic_urls = [dic valueForKey:@"pic_urls"];
        self.created_at = [dic valueForKey:@"created_at"];
        self.weibo_id = [dic valueForKey:@"id"];
        
    }
    return self;
}


@end
