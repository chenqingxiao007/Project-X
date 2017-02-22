//
//  ZQAccountTool.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/21.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQAccountTool.h"
// 文件保存路径 在Documents目录下创建文件
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@implementation ZQAccountTool
- (id)init
{
    if (self = [super init]) {
        //解归档该路径下的文件
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
    //将数据归档,如果前面的文件不存在，就会在归档数据时创建
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}
- (void)removeAccount
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kFile]) {
        [[NSFileManager defaultManager]removeItemAtPath:kFile error:nil];
    }
}
@end
