//
//  ZQMyHeaderBtn.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/24.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyHeaderBtn.h"
@interface ZQMyHeaderBtn()
@property (nonatomic, strong) UILabel *label_top;
@property (nonatomic, strong) UILabel *label_bottom;
@property (nonatomic, assign) NSInteger buttonTypeInteger;
@end
@implementation ZQMyHeaderBtn
- (void)setBottomMessage:(NSString *)bottomMessage{
    self.label_bottom.text = bottomMessage;
}
- (void)setBottomColor:(UIColor *)bottomColor{
    self.label_bottom.textColor = bottomColor;
    [self.label_bottom sizeToFit];

}

- (void)setTopColor:(UIColor *)topColor{
    self.label_top.textColor = topColor;
}
- (void)setTopMessage:(NSString *)topMessage{
    self.label_top.text = topMessage;
    [self.label_top sizeToFit];
}
- (void)setTopFont:(UIFont *)topFont{
    self.label_top.font = topFont;
}
- (void)setBottomFont:(UIFont *)bottomFont{
    self.label_bottom.font = bottomFont;
}

//init
- (instancetype)initWithButtonType:(ButtonType)buttonType{
    self = [super init];
    
    if (self) {
        switch (buttonType) {
            case 0:
                self.buttonTypeInteger = 0;
                break;
            case 1:
                self.buttonTypeInteger = 1;
                break;
            case 2:
                self.buttonTypeInteger = 2;
                break;
            default:
                break;
        }
        //创建两个label
        self.label_top = [[UILabel alloc]init];
        self.label_top.textAlignment = NSTextAlignmentCenter;
        self.label_top.textColor = self.topColor;
        self.label_top.font = self.topFont;
        [self addSubview:self.label_top];
        
        self.label_bottom = [[UILabel alloc]init];
        self.label_bottom.textAlignment = NSTextAlignmentCenter;
        self.label_bottom.textColor = self.bottomColor;
        self.label_bottom.font = self.bottomFont;
        [self addSubview:self.label_bottom];
    }
    return self;
}
+ (instancetype)initWithButtonType:(ButtonType)buttonType{
    return [[self alloc] initWithButtonType:buttonType];
}
//frame
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.buttonTypeInteger == 0) {
        CGFloat top_titleWidth = CGRectGetWidth(self.label_top.frame);
        [self.label_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(2);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(top_titleWidth);
        }];
        
        //bottom frame
        CGFloat bottom_titleWidth = CGRectGetWidth(self.label_bottom.frame);
        [self.label_bottom mas_makeConstraints:^(MASConstraintMaker *make) {

            make.right.equalTo(self.mas_centerX).offset(-2);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(bottom_titleWidth);
        }];

    }
    if (self.buttonTypeInteger == 1) {
        //top frame
        [self.label_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY).offset(-2);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(self.mas_width);
        }];
        
        //bottom frame
        [self.label_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).offset(2);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(self.mas_width);
        }];

    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.HeaderBtnBlock) {
        self.HeaderBtnBlock();
        
    }
}
@end
