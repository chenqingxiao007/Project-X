//
//  ZQMyCell.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/24.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQCellModel.h"
@interface ZQMyCell : UITableViewCell

@property (strong, nonatomic) ZQCellModel *cellModel;

@property (nonatomic, strong) UIImageView *imageView_icon;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_detail;
@property (nonatomic, strong) UIImageView *imageView_arrow;

//外界获取自定义的cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
