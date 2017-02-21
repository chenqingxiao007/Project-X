//
//  ZQAccountTool.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/21.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQAccountTool.h"
// 文件保存路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@implementation ZQAccountTool
- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

+ (instancetype)shareAccountTool{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)saveAccount:(ZQAccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}

@end
