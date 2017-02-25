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

//1.1级字体颜色（标题）
+ (UIColor *)firstWordColor;
//2.2级字体颜色
+ (UIColor *)secondWordColor;
//3.3级字体颜色
+ (UIColor *)thirdWordColor;
//4.特殊字体颜色 橘黄色
+ (UIColor *)orangeWordColor;
//5.分割线viewcolor
+ (UIColor *)separateLineViewColor;
@end
