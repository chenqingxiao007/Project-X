//
//  ZQMyHeaderCell.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/23.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQMyHeaderBtn.h"

@interface ZQMyHeaderCell : UITableViewCell
//点击头像回调blog
@property (nonatomic, copy) void(^ImageCliclBlock)();

@property (strong, nonatomic) ZQUserMessage *userMessage;

//**微博*/
@property (nonatomic, strong) ZQMyHeaderBtn *button_favourites;
//**关注*/
@property (nonatomic, strong) ZQMyHeaderBtn *button_friends;
//**粉丝*/
@property (nonatomic, strong) ZQMyHeaderBtn *button_followers;
//外界获取自定义的cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
