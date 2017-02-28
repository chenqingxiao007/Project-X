//
//  ZQProfileHeaderView.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/28.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuXSegmentView.h"
@interface ZQProfileHeaderView : UIView
@property (nonatomic, copy) void(^bgImageClickBlock)();
@property (nonatomic, copy) void(^iconImageClickBlock)();

@property (nonatomic, strong) LiuXSegmentView *segmentView;
@property (strong, nonatomic) ZQUserMessage *userMessage;
@property (nonatomic, strong) UIImageView *bgImageView;

@end
