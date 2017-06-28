//
//  ZQWeiboCell.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/27.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQWeiboCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZQWeiboCell ()

@property (strong, nonatomic)  UIImageView *profile_image_url_imageView;
@property (strong, nonatomic)  UILabel *screen_name_label;
@property (strong, nonatomic)  UILabel *text_label;
//@property (strong, nonatomic)  CXStatuePicView *picView;


@end

@implementation ZQWeiboCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.profile_image_url_imageView];
        [self addSubview:self.screen_name_label];
        [self addSubview:self.text_label];
    }
    return self;
}

- (void)setWeiboModel:(ZQWeiboModel *)weiboModel{
    _weiboModel = weiboModel;

    [self.profile_image_url_imageView sd_setImageWithURL:[NSURL URLWithString:_weiboModel.profile_image_url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    self.screen_name_label.text = _weiboModel.screen_name;
    [self.screen_name_label sizeToFit];
    self.screen_name_label.x = self.profile_image_url_imageView.maxX + 10;
    self.screen_name_label.y = self.profile_image_url_imageView.y;
    
    
    self.text_label.text = _weiboModel.text;
    [self.text_label sizeToFit];
    self.text_label.x = self.screen_name_label.x;
    self.text_label.y = self.screen_name_label.maxY + 20;

    
//    if (!self.picView) {
//        self.picView = [[CXStatuePicView alloc] initWithPic_urls:_statue.pic_urls];
//        
//        
//        self.picView.origin = CGPointMake(self.screen_name_label.x, self.text_label.maxY + 20);
//        [self addSubview:self.picView];
//        
//        
//    }
//    
//    
    self.height = self.screen_name_label.height + self.text_label.height + 40 + 30;
}


- (UIImageView *)profile_image_url_imageView{
    if (!_profile_image_url_imageView) {
        _profile_image_url_imageView = [[UIImageView alloc] init];
        _profile_image_url_imageView.frame = CGRectMake(10, 10, 40, 40);
        _profile_image_url_imageView.layer.cornerRadius = 20;
        _profile_image_url_imageView.layer.masksToBounds = YES;
    }
    return _profile_image_url_imageView;
}

- (UILabel *)screen_name_label{
    if (!_screen_name_label) {
        _screen_name_label = [[UILabel alloc] init];
        _screen_name_label.font = [UIFont systemFontOfSize:14];
    }
    return _screen_name_label;
}

- (UILabel *)text_label{
    if (!_text_label) {
        _text_label = [[UILabel alloc] init];
        _text_label.width = SCREEN_WIDTH - 75;
        _text_label.numberOfLines = 0;
        _text_label.textColor = [UIColor orangeWordColor];
    }
    return _text_label;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
