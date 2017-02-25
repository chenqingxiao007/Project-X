//
//  ZQMyHeaderCell.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/23.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyHeaderCell.h"
#import "SDWebImageManager.h"

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
        self.imageView_arrow = [[UIImageView alloc]init];
        [self addSubview:self.imageView_arrow];
        
        //添加是否是认证用户文字
        self.label_verified = [[UILabel alloc]init];
        self.label_verified.textColor = [UIColor orangeWordColor];
        self.label_verified.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.label_verified];
        
        //添加是否认证图标
        self.imageView_verified = [[UIImageView alloc]init];
        [self addSubview:self.imageView_verified];
        
        //添加昵称
        self.label_name = [[UILabel alloc]init];
        self.label_name.font = [UIFont systemFontOfSize:15];
        self.label_name.textColor = [UIColor firstWordColor];
        [self addSubview:self.label_name];

        //添加简介
        self.label_description = [[UILabel alloc]init];
        self.label_description.font = [UIFont systemFontOfSize:13];
        self.label_description.textColor = [UIColor thirdWordColor];
        [self addSubview:self.label_description];
        
        //添加中间灰色View
        self.garyView = [[UIView alloc]init];
        self.garyView.backgroundColor = [UIColor separateLineViewColor];
        [self addSubview:self.garyView];
        
        //添加微博btn
        self.button_favourites = [self addButtonWithMessage:@"微博"];
        //添加关注
        self.button_friends = [self addButtonWithMessage:@"关注"];
        //添加关注
        self.button_followers = [self addButtonWithMessage:@"粉丝"];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //头像frame
    [self.imageView_proflie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(60,60));
    }];
    self.imageView_proflie.layer.masksToBounds =YES;
    self.imageView_proflie.layer.cornerRadius =30;
    
    //箭头frame
    [self.imageView_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView_proflie);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(12,12));
    }];
    
    //用户是否认证label frame
    CGFloat verifiedLabelWidth = CGRectGetWidth(self.label_verified.frame);
    [self.label_verified mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView_arrow.mas_centerY);
        make.right.equalTo(self.imageView_arrow.mas_left).offset(-2);
        make.width.mas_equalTo(verifiedLabelWidth);
    }];

    //用户是否认证图标 frame
    [self.imageView_verified mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label_verified.mas_centerY);
        make.right.equalTo(self.label_verified.mas_left).offset(-2);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];

    //用户昵称 frame
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageView_proflie.mas_centerY).offset(-2);
        make.left.equalTo(self.imageView_proflie.mas_right).offset(10);
        make.right.equalTo(self.imageView_verified.mas_left).offset(-10);
    }];

    //简介frame
    [self.label_description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView_proflie.mas_centerY).offset(2);
        make.left.equalTo(self.imageView_proflie.mas_right).offset(10);
        make.right.equalTo(self.imageView_verified.mas_left).offset(-10);
    }];
    
    //中间View frame
    [self.garyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.imageView_proflie.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //微博 Btn frame
    [self.button_favourites mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.garyView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width).multipliedBy(0.33);
    }];
    //关注 Btn frame
    [self.button_friends mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.garyView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.button_favourites.mas_width);
    }];
    //粉丝 Btn frame
    [self.button_followers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.garyView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.button_favourites);
    }];

    
    
}
- (void)setUserMessage:(ZQUserMessage *)userMessage{
    if (userMessage) {
        NSURL *imageDownUrl = [NSURL URLWithString:userMessage.profile_image_url];
        [[SDWebImageManager sharedManager]downloadImageWithURL:imageDownUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //下载进度
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                self.imageView_proflie.image = image;
            }
            if (error) {
                NSLog(@"%@",error);
            }
        }];
#pragma mark --  判断是否有消息  暂时用箭头 不需要红色原点
        self.imageView_arrow.image = [UIImage imageNamed:my_yellowarrow];
        if (userMessage.verified == 0) {
            //普通用户
            self.label_verified.text = @"普通用户";
            self.imageView_verified.image = [UIImage imageNamed:my_commonUser];
        }else{
            //认证用户
            self.label_verified.text = @"认证用户";
            self.imageView_verified.image = [UIImage imageNamed:my_membership];
        }
        [self.label_verified sizeToFit];
        self.label_name.text = userMessage.screen_name;
        self.label_description.text = [NSString stringWithFormat:@"简介：%@",userMessage.WBdescription];
        
        //微博
        self.button_favourites.topMessage = [NSString stringWithFormat:@"%ld",(long)userMessage.favourites_count];
        //关注
        self.button_friends.topMessage = [NSString stringWithFormat:@"%ld",(long)userMessage.friends_count];
        //粉丝
        self.button_followers.topMessage = [NSString stringWithFormat:@"%ld",(long)userMessage.followers_count];
    }
}
//添加按钮
- (void)setUpBtnWithBtn:(ZQMyHeaderBtn *)button withBottomMessage:(NSString *)bottomMessage{
    button = [[ZQMyHeaderBtn alloc]init];
    button.bottomMessage = bottomMessage;
    button.topColor = [UIColor firstWordColor];
    button.bottomColor = [UIColor thirdWordColor];
    [self addSubview:button];
}
//添加按钮
- (ZQMyHeaderBtn *)addButtonWithMessage:(NSString *)bottomMessage{
    ZQMyHeaderBtn *btn = [[ZQMyHeaderBtn alloc]init];
    btn.bottomMessage = @"微博";
    btn.topColor = [UIColor firstWordColor];
    btn.bottomColor = [UIColor thirdWordColor];
    [self addSubview:btn];
    return btn;
}
@end
