//
//  ZQMyHeaderCell.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/23.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyHeaderCell.h"

@implementation ZQMyHeaderCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"myHeaderCell";
    ZQMyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZQMyHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}
//添加cell的控件.
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加头像
        self.imageView_proflie = [[UIImageView alloc]init];
        [self addSubview:self.imageView_proflie];
        
        //添加箭头
        self.imageView_yellowArrow = [[UIImageView alloc]init];
        [self addSubview:self.imageView_yellowArrow];
        
        //添加是否是认证用户文字
        self.label_verified = [[UILabel alloc]init];
        self.label_verified.textColor = [UIColor orangeColor];
        self.label_verified.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.label_verified];
        
        //添加是否认证图标
        self.imageView_verified = [[UIImageView alloc]init];
        [self addSubview:self.imageView_verified];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //头像frame
    [self.imageView_proflie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(60,60));
    }];
    
    //箭头frame
    [self.imageView_yellowArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView_proflie);
        make.right.equalTo(self).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(12,12));
    }];
    
    //用户是否认证label frame
    [self.label_verified mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView_yellowArrow);
        make.right.equalTo(self.imageView_yellowArrow).with.offset(-10);
        make.width.lessThanOrEqualTo(self.label_verified.superview);
    }];
    
    //用户是否认证图标 frame
    [self.imageView_verified mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label_verified);
        make.right.equalTo(self.label_verified).with.offset(-10);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];


}
- (void)setUserMessage:(ZQUserMessage *)userMessage{
    if (userMessage) {
        self.imageView_proflie.image = [UIImage imageNamed:my_friend];
#pragma mark --  判断是否有消息  暂时用箭头 不需要红色原点
        self.imageView_yellowArrow.image = [UIImage imageNamed:my_yellowarrow];
        if (userMessage.verified == 0) {
            //普通用户
            self.label_verified.text = @"普通用户";
            self.imageView_verified.image = [UIImage imageNamed:my_commonUser];
        }else{
            //认证用户
            self.label_verified.text = @"认证用户";
            self.imageView_verified.image = [UIImage imageNamed:my_membership];

        }
    }
}

@end
