 //
//  ZQMyCell.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/24.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQMyCell.h"

@implementation ZQMyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"myCell";
    ZQMyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZQMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}
//添加cell的控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加icon
        self.imageView_icon = [[UIImageView alloc]init];
        [self addSubview:self.imageView_icon];
        
        self.label_title = [[UILabel alloc]init];
        self.label_title.textColor = [UIColor secondWordColor];
        self.label_title.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.label_title];
        
        self.label_detail = [[UILabel alloc]init];
        self.label_detail.font = [UIFont systemFontOfSize:12];
        self.label_detail.textColor = [UIColor thirdWordColor];
        [self addSubview:self.label_detail];
        
        self.imageView_arrow = [[UIImageView alloc]init];
        [self addSubview:self.imageView_arrow];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.icon
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //2.title
    CGFloat label_titleWidth = CGRectGetWidth(self.label_title.frame);
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.imageView_icon.mas_right).offset(10);
        make.width.mas_equalTo(label_titleWidth);
    }];
    
    //3.arrow

    [self.imageView_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    //4.detail
    [self.label_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.label_title.mas_right).offset(10);
        make.right.mas_equalTo(self.imageView_arrow.mas_left).offset(-10);

    }];
}

- (void)setCellModel:(ZQCellModel *)cellModel{
    self.imageView_icon.image = [UIImage imageNamed:cellModel.icon];
    self.label_title.text = cellModel.title;
    [self.label_title sizeToFit];

    self.label_detail.text = cellModel.introduce;
    
#pragma mark 这里需要判断是红点还是箭头
    self.imageView_arrow.image = [UIImage imageNamed:my_grayarrow];
}
@end
