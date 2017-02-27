//
//  ZQHomeModel.h
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/27.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQWeiboModel.h"

@interface ZQHomeModel : NSObject

@property (nonatomic, strong) NSMutableArray *weiboModels;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
