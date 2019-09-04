//
//  KddMessageController.h
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCell.h"
#import "TextMessageCell.h"
#import "ImageMessageCell.h"
#import "define.h"
#import "Receive.h"

@class KddMessageController;
@protocol KddMessageControllerDelegate <NSObject>

- (void) didTapChatMessageView;

@end

@interface KddMessageController : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray * dataArray;
    
}

@property (nonatomic,strong) id <KddMessageControllerDelegate> delegate;

@property(nonatomic,strong)UITableView * tableview;


/**
 *  改变数据源方法，添加一条消息，刷新数据
 *
 *  @param message 添加的消息
 */
- (void)addNewMessage:(Receive *)message;

/**
 *   添加一条消息就让tableView滑动
 */
- (void) scrollToBottom;

@end
