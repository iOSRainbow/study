//
//  MessageCell.h
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receive.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "define.h"

@interface MessageCell : UITableViewCell

@property(nonatomic,strong)Receive * recevie;

/**
 *  其他的cell 继承与这个cell，这个cell中只有头像是共有的，就只写头像，其他的就在各自cell中去写。
 */
@property (nonatomic, strong) UIImageView *avatarImageView;                 // 头像
@property (nonatomic, strong) UIImageView *messageBackgroundImageView;      // 消息背景
@property (nonatomic, strong) UIImageView *messageSendStatusImageView;      // 消息发送状态

@end
