//
//  ZQGlobleMessage.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/23.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQUserMessage.h"
@interface ZQGlobleMessage : NSObject
//**全局用户信息类*/
@property (nonatomic, strong) ZQUserMessage *userMessage;

+ (ZQGlobleMessage *)shareInstence;
@end
