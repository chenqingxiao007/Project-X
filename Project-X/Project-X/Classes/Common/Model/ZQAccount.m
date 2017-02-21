//
//  ZQAccount.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/21.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQAccount.h"

@implementation ZQAccount
+ (instancetype)accountWithDic:(NSDictionary *)dic{
    
    ZQAccount *account = [[ZQAccount alloc] init];
    account.access_token = [dic valueForKey:@"access_token"];
    account.uid = [dic valueForKey:@"uid"];
    account.expires_in = [dic valueForKey:@"expires_in"];
    account.remind_in = [dic valueForKey:@"remind_in"];
    
    return account;
}

#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_access_token forKey:@"access_token"];
    [encoder encodeObject:_uid forKey:@"uid"];
    [encoder encodeObject:_uid forKey:@"expires_in"];
    [encoder encodeObject:_uid forKey:@"remind_in"];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
    }
    return self;
}



@end
