//
//  ZQUserMessage.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/22.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQUserMessage.h"

@implementation ZQUserMessage
////**头像地址*/
//@property (nonatomic, copy) NSString *profile_image_url;
//
////**用户昵称*/
//@property (nonatomic, copy) NSString *screen_name;
//
////**是否是微博认证用户*/
//@property (nonatomic, assign) NSInteger verified;
//
////**自我描述*/
//@property (nonatomic, copy) NSString *WBdescription;
//
////**微博数*/
//@property (nonatomic, assign) NSInteger favourites_count;
//
////**关注数*/
//@property (nonatomic, assign) NSInteger friends_count;
//
////**粉丝数*/
//@property (nonatomic, assign) NSInteger followers_count;
#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_profile_image_url forKey:@"profile_image_url"];
    [encoder encodeObject:_screen_name forKey:@"screen_name"];
    [encoder encodeInteger:_verified forKey:@"verified"];
    [encoder encodeObject:_WBdescription forKey:@"description"];
    [encoder encodeInteger:_favourites_count forKey:@"favourites_count"];
    [encoder encodeInteger:_friends_count forKey:@"friends_count"];
    [encoder encodeInteger:_followers_count forKey:@"followers_count"];
//    [encoder encodeObject:_insecurity forKey:@"insecurity"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.profile_image_url = [decoder decodeObjectForKey:@"profile_image_url"];
        self.screen_name = [decoder decodeObjectForKey:@"screen_name"];
        self.verified = [decoder decodeIntegerForKey:@"verified"];
        self.WBdescription = [decoder decodeObjectForKey:@"description"];
        self.favourites_count = [decoder decodeIntegerForKey:@"favourites_count"];
        self.friends_count = [decoder decodeIntegerForKey:@"friends_count"];
        self.followers_count = [decoder decodeIntegerForKey:@"followers_count"];
//        self.insecurity = [decoder decodeObjectForKey:@"insecurity"];
    }
    return self;
}


//模型中属性名和字典中key不同进行替换
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"WBdescription":@"description"};
}
@end
