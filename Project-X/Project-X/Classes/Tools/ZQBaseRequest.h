//
//  ZQBaseRequest.h
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/17.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQBaseRequest : NSObject


@property (nonatomic, strong, readonly) NSMutableDictionary *params;

@property (nonatomic, strong, readonly) NSString *url;

@property (nonatomic, copy, readonly) NSString *methodType;


/// baseURL
- (NSString *)baseUrl;
/// 请求类型
- (NSString *)methodType;
/// 请求参数
- (NSMutableDictionary *)pathParam;


@end
