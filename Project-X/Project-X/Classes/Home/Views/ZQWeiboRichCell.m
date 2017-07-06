//
//  ZQWeiboRichCell.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/7/6.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQWeiboRichCell.h"


@interface ZQWeiboRichCell ()

@property (strong, nonatomic)  UIImageView *profile_image_url_imageView;
@property (strong, nonatomic)  UILabel *screen_name_label;
@property (strong, nonatomic)  UILabel *text_label;

@end
@implementation ZQWeiboRichCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.profile_image_url_imageView];
        [self addSubview:self.screen_name_label];
        [self addSubview:self.text_label];
    }
    return self;
}

- (void)setWeiboModel:(ZQWeiboModel *)weiboModel{
    _weiboModel = weiboModel;
    
//    [self.profile_image_url_imageView sd_setImageWithURL:[NSURL URLWithString:_weiboModel.profile_image_url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    
    self.screen_name_label.text = _weiboModel.screen_name;
    [self.screen_name_label sizeToFit];
    self.screen_name_label.x = self.profile_image_url_imageView.maxX + 10;
    self.screen_name_label.y = self.profile_image_url_imageView.y;
    
    
    self.text_label.text = _weiboModel.text;
    [self.text_label sizeToFit];
    self.text_label.x = self.screen_name_label.x;
    self.text_label.y = self.screen_name_label.maxY + 20;
    
    
    self.height = self.screen_name_label.height + self.text_label.height + 40 + 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
