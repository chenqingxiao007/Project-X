//
//  ZQMyCell.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/24.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZQCellModel;
@interface ZQMyCell : UITableViewCell

@property (strong, nonatomic) ZQCellModel *cellModel;

//外界获取自定义的cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
