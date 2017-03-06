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

+ (void)getUsers{
    
    if (Acount) {
        NSDictionary *paramenters = @{@"access_token":Acount.access_token,
                                      @"uid":Acount.uid};
        [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypeGet url:getUsers params:paramenters success:^(id responseObject) {
            //
            NSLog(@"responseObject%@",responseObject);
            
            ZQUserMessage *userMessage = [ZQUserMessage mj_objectWithKeyValues:responseObject];
            //存储
            NSData *userMessageData = [NSKeyedArchiver archivedDataWithRootObject:userMessage];
            [[NSUserDefaults standardUserDefaults] setObject:userMessageData forKey:@"theuserMessage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //获取
            //获得保存数据
            NSData *getuserMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"theuserMessage"];
            
            
            //转成模型获取数据
            ZQUserMessage *getuserMessage =   [NSKeyedUnarchiver unarchiveObjectWithData:getuserMessageData];
            UserMessage = getuserMessage;
            NSLog(@"userMessage%@",userMessage.screen_name);
        } failure:^(NSError *error) {
            //
            NSLog(@"失败了");
        }];
        
    }
    
}
@end
