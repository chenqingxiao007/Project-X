//
//  ZQBaseRequest.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/17.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQBaseRequest.h"

@interface ZQBaseRequest ()

@property (nonatomic, strong) NSMutableDictionary *params;

@end


@implementation ZQBaseRequest



- (instancetype)init {
    if (self = [super init]) {
        NSString *baseUrl = [self baseUrl];
    }
    return self;
}

- (NSMutableDictionary *)pathParam {
    if (nil == _params) {
        _params = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _params;

}

- (NSString *)baseUrl {
    return @"";
}

- (NSString *)methodType {
    return @"";
}


@end
