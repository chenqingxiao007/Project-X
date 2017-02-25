//
//  ZQMyHeaderBtn.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/24.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQMyHeaderBtn : UIView

//**点击view回调block*/
@property (nonatomic, copy) void(^HeaderBtnBlock)();

@property (strong, nonatomic) NSString *topMessage;
@property (strong, nonatomic) NSString *bottomMessage;
@property (strong, nonatomic) UIColor *topColor;
@property (strong, nonatomic) UIColor *bottomColor;
@property (strong, nonatomic) UIFont *bottomFont;
@property (strong, nonatomic) UIFont *topFont;

@end
