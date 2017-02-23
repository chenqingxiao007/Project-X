//
//  ZQMyHeaderCell.h
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/2/23.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZQMyHeaderCell : UITableViewCell
@property (strong, nonatomic) ZQUserMessage *userMessage;
//**头像*/
@property (nonatomic, strong) UIImageView *imageView_proflie;

//**用户昵称*/
@property (nonatomic, strong) UILabel *label_name;

//**自我描述*/
@property (nonatomic, strong) UILabel *label_description;

//**是否认证认证用户*/
@property (nonatomic, strong) UIImageView *imageView_verified;
@property (nonatomic, strong) UILabel *label_verified;
@property (nonatomic, strong) UIImageView *imageView_redMessage;
@property (nonatomic, strong) UIImageView *imageView_yellowArrow;


//**微博*/
@property (nonatomic, strong) UIButton *button_favourites;

//**关注*/
@property (nonatomic, strong) UIButton *button_friends;

//**粉丝*/
@property (nonatomic, strong) UIButton *button_followers;


//外界获取自定义的cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
