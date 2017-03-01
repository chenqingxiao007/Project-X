//
//  ZQMyHeaderBtn.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/24.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//**两个文字 上下左右显示btn*/

#import <UIKit/UIKit.h>

@interface ZQMyHeaderBtn : UIView
typedef NS_ENUM(NSInteger, ButtonType) {
    TypeLeftRight,//左右形势
    TypeUpBottom,//上下形式
    Other//可以点击有标示箭头的形式
};
//**点击view回调block*/
@property (nonatomic, copy) void(^HeaderBtnBlock)();

@property (strong, nonatomic) NSString *topMessage;
@property (strong, nonatomic) NSString *bottomMessage;
@property (strong, nonatomic) UIColor *topColor;
@property (strong, nonatomic) UIColor *bottomColor;
@property (strong, nonatomic) UIFont *bottomFont;
@property (strong, nonatomic) UIFont *topFont;

+ (instancetype)initWithButtonType:(ButtonType)buttonType;
@end
