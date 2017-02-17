//
//  ZQNetWorkHelper.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/17.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQNetWorkHelper.h"
#import <AFNetworking/AFNetworking.h>

@implementation ZQNetWorkHelper

+ (instancetype)sharedNetWorkHelper{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (void)invokeWithType:(ZQInvokeType)invokeType url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    switch (invokeType) {
        case ZQInvokeTypeGet: {
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                    if (error.code == NSURLErrorNotConnectedToInternet) {
                        NSLog(@"网络有点不给力");
                    }
                }
            }];
        }
            
            break;
            
        case ZQInvokeTypePost: {
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                    if (error.code == NSURLErrorNotConnectedToInternet) {
                        NSLog(@"网络有点不给力");
                    }
                }
            }];
        }
            break;
        default:
            break;
    }
    
    
    
    
}


@end
