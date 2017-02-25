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
@end
@implementation ZQMyHeaderBtn
- (void)setBottomMessage:(NSString *)bottomMessage{
    self.label_bottom.text = bottomMessage;
}
- (void)setBottomColor:(UIColor *)bottomColor{
    self.label_bottom.textColor = bottomColor;
}

- (void)setTopColor:(UIColor *)topColor{
    self.label_top.textColor = topColor;
}
- (void)setTopMessage:(NSString *)topMessage{
    self.label_top.text = topMessage;
}

////init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //创建两个label
        self.label_top = [[UILabel alloc]init];
        self.label_top.textAlignment = NSTextAlignmentCenter;
        self.label_top.textColor = self.topColor;
        self.label_top.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label_top];
        
        self.label_bottom = [[UILabel alloc]init];
        self.label_bottom.textAlignment = NSTextAlignmentCenter;
        self.label_bottom.textColor = self.bottomColor;
        self.label_bottom.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label_bottom];
    }
    return self;
}
//frame
- (void)layoutSubviews{
    [super layoutSubviews];
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.HeaderBtnBlock) {
        self.HeaderBtnBlock();
        
    }
}
@end
