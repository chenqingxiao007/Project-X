//
//  ZQProfileHeaderView.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/28.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQProfileHeaderView.h"
#import "SDWebImageManager.h"
@interface ZQProfileHeaderView()
@property (nonatomic, strong) UIImageView *imageView_icon;
@property (nonatomic, strong) UILabel *label_name;
//@property (nonatomic, strong) UIImageView *imageView_sex;
//@property (nonatomic, strong) UILabel *label_friends;
//@property (nonatomic, strong) UILabel *label_followers;
//@property (nonatomic, strong) UIView *view_line;
//@property (nonatomic, strong) UILabel *label_description;
//@property (nonatomic, strong) UIImageView *imageView_edit;


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
    self.imageView_icon.layer.masksToBounds =YES;
    self.imageView_icon.layer.cornerRadius =30;
    //name label
    CGFloat nameLabelWidth = CGRectGetWidth(self.label_name.frame);
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView_icon.mas_centerX);
        make.top.equalTo(self.imageView_icon.mas_bottom).offset(5);
        make.width.mas_equalTo(nameLabelWidth);


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
                self.imageView_icon.image = image;
            }
            if (error) {
                NSLog(@"%@",error);
            }
        }];

        self.label_name.text = userMessage.screen_name;
        [self.label_name sizeToFit];
    }
}
@end
