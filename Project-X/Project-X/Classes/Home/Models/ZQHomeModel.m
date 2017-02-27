//
//  ZQHomeModel.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/27.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQHomeModel.h"

@implementation ZQHomeModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.weiboModels = [[NSMutableArray alloc] init];
        NSArray *array = [dict valueForKey:@"statuses"];
        
        for (NSDictionary *statueDic in array) {
            ZQWeiboModel *weiboModel = [[ZQWeiboModel alloc] initWithDic:statueDic];
            [self.weiboModels addObject:weiboModel];
        }

    }
    return self;
}

@end
