//
//  ZQUserMessage.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/22.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQUserMessage.h"

@implementation ZQUserMessage

//模型中属性名和字典中key不同进行替换
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"WBdescription":@"description"};
}

@end
