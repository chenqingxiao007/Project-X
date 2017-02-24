//
//  UIColor+ex.h
//  XinErFu
//
//  Created by 张庆庆 on 16/2/27.
//  Copyright © 2016年 ZQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ex)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end
