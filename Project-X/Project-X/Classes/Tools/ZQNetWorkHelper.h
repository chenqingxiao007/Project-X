//
//  ZQNetWorkHelper.h
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/17.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQBaseRequest.h"

typedef NS_ENUM(NSUInteger, ZQInvokeType) {
    ZQInvokeTypeGet,
    ZQInvokeTypePost,
};


@interface ZQNetWorkHelper : NSObject

+ (instancetype)sharedNetWorkHelper;

- (void)invokeWithType:(ZQInvokeType)invokeType url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
