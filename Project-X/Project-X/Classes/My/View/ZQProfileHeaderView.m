//
//  ZQProfileHeaderView.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/28.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQProfileHeaderView.h"
#import "SDWebImageManager.h"
#import "ZQMyHeaderBtn.h"
@interface ZQProfileHeaderView()
@property (nonatomic, strong) UIImageView *imageView_icon;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UIImageView *imageView_sex;
@property (nonatomic, strong) ZQMyHeaderBtn *button_friends;
@property (nonatomic, strong) ZQMyHeaderBtn *button_followers;
@property (nonatomic, strong) UIView *view_line;
@property (nonatomic, strong) UILabel *label_description;
@property (nonatomic, strong) UIImageView *imageView_member;
@property (nonatomic, strong) UIImageView *imageView_edit;


@end
@implementation ZQProfileHeaderView

//init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景imageView
        self.bgImageView = [[UIImageView alloc]init];
        self.bgImageView.userInteractionEnabled = YES;
        self.bgImageView.image = [UIImage imageNamed:profile_background];
        [self addSubview:self.bgImageView];
        
        //添加头像
        self.imageView_icon = [[UIImageView alloc]init];
        self.imageView_icon.userInteractionEnabled = YES;
        [self addSubview:self.imageView_icon];
        
        //添加昵称label
        self.label_name = [[UILabel alloc]init];
        self.label_name.font = First_font;
        self.label_name.textColor = [UIColor whiteColor];
        [self addSubview:self.label_name];
        
        //添加中间view
        self.view_line = [[UIView alloc]init];
        self.view_line.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.view_line];
        
        //添加button
        self.button_friends = [self addButtonWithMessage:my_cell_friends];
        self.button_followers = [self addButtonWithMessage:my_cell_followers];
        
        //添加简介
        self.label_description = [[UILabel alloc]init];
        self.label_description.font = Small_font;
        self.label_description.textColor = [UIColor whiteColor];
        [self addSubview:self.label_description];
        
        //添加性别image
        self.imageView_sex = [[UIImageView alloc]init];
        [self addSubview:self.imageView_sex];
        
        //添加会员image
        self.imageView_member = [[UIImageView alloc]init];
        [self addSubview:self.imageView_member];
        
        //添加 编辑image
        self.imageView_edit = [[UIImageView alloc]init];
        self.imageView_edit.image = [UIImage imageNamed:my_pofile_edit];
        [self addSubview:self.imageView_edit];
    }
    return self;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //bgImageView
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.height.mas_equalTo(360);
    }];
    //头像
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView.mas_centerX);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(60,60));

    }];
    //此处代码消耗性能 是离屏渲染（off-screen-rendering）
//    self.imageView_icon.layer.masksToBounds =YES;
//    self.imageView_icon.layer.cornerRadius =30;
    //name label
    CGFloat nameLabelWidth = CGRectGetWidth(self.label_name.frame);
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView_icon.mas_centerX);
        make.top.equalTo(self.imageView_icon.mas_bottom).offset(5);
        make.width.mas_equalTo(nameLabelWidth);

    }];
    //view_line frame
    [self.view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.label_name.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(1,13));

    }];
    //添加两个按钮 frame
    [self.button_friends mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_name.mas_bottom).offset(7);
        make.right.equalTo(self.view_line.mas_left).offset(7);
        make.size.mas_equalTo(CGSizeMake(70,15));
    }];
    //添加两个按钮 frame
    [self.button_followers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_name.mas_bottom).offset(7);
        make.left.equalTo(self.view_line.mas_right).offset(7);
        make.size.mas_equalTo(CGSizeMake(70,15));
    }];
    
    
    //简介 frame
    CGFloat descriptionLabelWidth = CGRectGetWidth(self.label_description.frame);
    [self.label_description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.view_line.mas_bottom).offset(7);
        make.width.mas_equalTo(descriptionLabelWidth);
    }];
    
    //性别image frame
    [self.imageView_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_name.mas_right).offset(5);
        make.centerY.equalTo(self.label_name.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    //会员image frame
    [self.imageView_member mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView_sex.mas_right).offset(5);
        make.centerY.equalTo(self.label_name.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
    
    //编辑image frame
    [self.imageView_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_description.mas_right);
        make.centerY.equalTo(self.label_description.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18, 12));
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] ==  self.bgImageView) {
        if (self.bgImageClickBlock) {
            self.bgImageClickBlock();
        }
        NSLog(@"点击了背景图");
    }
    if ([touch view] ==  self.imageView_icon) {
        if (self.iconImageClickBlock) {
            self.iconImageClickBlock();
        }
        NSLog(@"点击了头像");
    }
}
- (void)setUserMessage:(ZQUserMessage *)userMessage{
    if (userMessage) {
        NSURL *imageDownUrl = [NSURL URLWithString:userMessage.profile_image_url];
        [[SDWebImageManager sharedManager]downloadImageWithURL:imageDownUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //下载进度
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                //on-screen-rendering
                image =  [image imageWithCornerRadius:30];
                self.imageView_icon.image = image;
            }
            if (error) {
                NSLog(@"%@",error);
            }
        }];

        self.label_name.text = userMessage.screen_name;
        [self.label_name sizeToFit];
        self.button_followers.topMessage = [NSString stringWithFormat:@"%ld",(long)userMessage.followers_count];
        self.button_friends.topMessage = [NSString stringWithFormat:@"%ld",(long)userMessage.friends_count];
        
        //简介
        self.label_description.text = [NSString stringWithFormat:@"简介：%@",userMessage.WBdescription];
        [self.label_description sizeToFit];
        
        NSString *sexStr = userMessage.gender;
        NSLog(@"gender%@",sexStr);
        if ([sexStr isEqualToString:@"m"]) {
            //男
            self.imageView_sex.image = [UIImage imageNamed:profile_male];
        }else if ([sexStr isEqualToString:@"f"]) {
            //女
            self.imageView_sex.image = [UIImage imageNamed:profile_female];
        }else{
            //未知
            self.imageView_sex.image = [UIImage imageNamed:profile_unchecked];
        }
        
        if (userMessage.verified == 0) {
            //普通用户
            self.imageView_member.image = [UIImage imageNamed:profile_open_membership];
        }else{
            //认证用户
            return;
        }

    }
}

//添加按钮
- (ZQMyHeaderBtn *)addButtonWithMessage:(NSString *)bottomMessage{
    ZQMyHeaderBtn *btn = [ZQMyHeaderBtn initWithButtonType:TypeLeftRight];
    btn.bottomMessage = bottomMessage;
    btn.topColor = [UIColor whiteColor];
    btn.bottomColor = [UIColor whiteColor];
    btn.topFont = Third_font;
    btn.bottomFont = Third_font;
    [self addSubview:btn];
    return btn;
}
@end
