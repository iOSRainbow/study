//
//  ChatToolbar.h
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "UIImage+Color.h"
#import "UIView+Frame.h"

#import "ChatMoreView.h"
#import "ChatFaceView.h"


typedef NS_ENUM(NSInteger ,inputType) {
    
    inputText,//键盘文本输入
    inputEmoji,//emoji
};

typedef NS_ENUM(NSInteger ,voiceStatus) {
    
    startVoice,//开始录音
    endVoice,//结束
};


@class ChatToolbar;
@protocol ChatToolbarDelegate <NSObject>

//改变toolbar高度
-(void)chatToolbarHeight:(CGFloat)height;
-(void)chatToolbardidchangeHeight:(CGFloat)height type:(inputType)type;//type:0文本输入、2表情输入;

-(void)chatDidchangeRecordStatus:(voiceStatus)state;

//发送消息
-(void)sendMessage:(NSAttributedString*)textMessage;

@end

@interface ChatToolbar : UIView<UITextViewDelegate,ChatFaceViewDelegate>
{
    CGFloat width;//chatToolbar初始宽度
    
    UIView * topLineView;//顶部横线
    UIButton * voiceButton;//语音按钮
    UITextView * textView;//文本、富文本输入框
    UIButton * faceButton;//表情按钮
    UIButton * moreButton;//更多按钮
    UIButton * talkButton;//聊天键盘按钮
    
    UIView * toolView;
    ChatMoreView * chatMoreView;
    ChatFaceView * chatFaceView;
}

@property (nonatomic, assign) id<ChatToolbarDelegate>delegate;

@property(nonatomic,assign)CGFloat toolbarHeight;//chatToolbar初始高度
@property(nonatomic,assign)inputType type;//输入类型
@property(nonatomic,assign)voiceStatus voicestate;//语音

-(void)hiden;

@end
