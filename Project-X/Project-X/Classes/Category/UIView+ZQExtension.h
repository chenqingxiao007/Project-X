//
//  UIView+ZQExtension.h
//  乐聊Cochat
//
//  Created by 陈擎霄 on 2017/02/27.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LNExtension)

@property (nonatomic) CGFloat x;        ///< frame.origin.x 简写.
@property (nonatomic) CGFloat y;         ///< frame.origin.y 简写
@property (nonatomic) CGFloat maxX;       ///< view的最大X值
@property (nonatomic) CGFloat maxY;      ///< view的最大Y值
@property (nonatomic) CGFloat width;       ///< frame.size.width 简写
@property (nonatomic) CGFloat height;      ///< frame.size.height 简写
@property (nonatomic) CGFloat centerX;     ///< center.x 简写
@property (nonatomic) CGFloat centerY;     ///< center.y 简写
@property (nonatomic) CGPoint origin;      ///< frame.origin 简写
@property (nonatomic) CGSize  size;        ///< frame.size 简写

@end
