//
//  Receive.h
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "define.h"


/**
 *  消息拥有者
 */
typedef NS_ENUM(NSUInteger, MessageOwnerType){
    MessageOwnerTypeSelf,     // 自己发送的消息
    MessageOwnerTypeOther,    // 接收到的他人消息
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, MessageType){
    MessageTypeText,          // 文字
    MessageTypeImage,         // 图片
    MessageTypeVoice,         // 语音
};

/**
 *  消息发送状态
 */
typedef NS_ENUM(NSUInteger, MessageSendState){
    MessageSendSuccess,       // 消息发送成功
    MessageSendFail,          // 消息发送失败
};

/**
 *  消息读取状态
 */
typedef NS_ENUM(NSUInteger, MessageReadState) {
    
    MessageUnRead,            // 消息未读
    MessageReaded,            // 消息已读
};

@interface Receive : NSObject

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *portrait;


@property (nonatomic, strong) NSString *dateString;     // 格式化的发送时间
@property (nonatomic, assign) MessageType messageType;         // 消息类型
@property (nonatomic, assign) MessageOwnerType ownerTyper;     // 发送者类型
@property (nonatomic, assign) MessageReadState readState;      // 读取状态
@property (nonatomic, assign) MessageSendState sendState;      // 发送状态

@property (nonatomic, assign) CGSize messageSize;   // 消息大小
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSString *cellIndentify;


#pragma mark - 文字消息
@property (nonatomic, strong) NSAttributedString *attrText;     //文字信息

#pragma mark - 图片消息
@property (nonatomic, strong) NSString *imageURL;    // 网络图片URL
@property(nonatomic,assign)CGFloat rate_width;//网络图片比例
@property(nonatomic,assign)CGFloat rate_height;//网络图片比例

@end
