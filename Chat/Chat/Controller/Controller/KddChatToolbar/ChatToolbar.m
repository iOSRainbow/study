//
//  ChatToolbar.m
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ChatToolbar.h"

@implementation ChatToolbar


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];

        _toolbarHeight = 49;// 当前高度初始化为 49

        width =SCREEN_WIDTH;
        
        self.type=inputText;
        self.voicestate=endVoice;
        [self chatToolView];
    
    }
    
    return self;
    
}

#pragma mark tool bar
-(void)chatToolView{
    
    toolView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, _toolbarHeight)];
    toolView.backgroundColor=[UIColor whiteColor];
    [self addSubview:toolView];
    
    //顶部横线
    topLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
    topLineView.backgroundColor=[UIColor grayColor];
    [toolView addSubview:topLineView];
    
    //语音
    voiceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    voiceButton.frame=CGRectMake(0, 6, 37, 37);
    [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
    [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
    [voiceButton addTarget:self action:@selector(voiceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:voiceButton];
    
    //输入框
    textView = [[UITextView alloc] initWithFrame:CGRectMake(42, 7, width-126, 35)];
    textView.font=[UIFont systemFontOfSize:16];
    textView.layer.masksToBounds=YES;
    textView.layer.cornerRadius=4;
    textView.layer.borderWidth=0.5;
    textView.layer.borderColor=[UIColor grayColor].CGColor;
    textView.scrollsToTop=NO;
    textView.scrollEnabled=NO;
    textView.returnKeyType=UIReturnKeySend;//返回按钮更改为发送
    textView.delegate=self;
    [toolView addSubview:textView];
    
    
    //表情
    faceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    faceButton.frame=CGRectMake(width-79, 6, 37, 37);
    [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
    [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
    [faceButton addTarget:self action:@selector(faceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:faceButton];
    
    //更多
    moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame=CGRectMake(width-37, 6, 37, 37);
    [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:moreButton];
    
    
    //聊天键盘
    talkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    talkButton.frame=textView.frame;
    [talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [talkButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [talkButton setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] forState:UIControlStateNormal];
    [talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateHighlighted];
    [talkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [talkButton.layer setMasksToBounds:YES];
    [talkButton.layer setCornerRadius:4.0f];
    [talkButton.layer setBorderWidth:0.5f];
    [talkButton.layer setBorderColor:topLineView.backgroundColor.CGColor];
    [talkButton setHidden:YES];
    [talkButton addTarget:self action:@selector(talkButtonDown:) forControlEvents:UIControlEventTouchDown];
    [talkButton addTarget:self action:@selector(talkButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [talkButton addTarget:self action:@selector(talkButtonUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [toolView addSubview:talkButton];
}

#pragma mark 更多View
-(void)chatMoreView{
    
    [chatMoreView removeFromSuperview];
    chatMoreView=[[ChatMoreView alloc] initWithFrame:CGRectMake(0,_toolbarHeight, width, 110)];
    [self addSubview:chatMoreView];
}

#pragma makr face view
-(void)chatFaceView{
    
    [chatFaceView removeFromSuperview];
    chatFaceView=[[ChatFaceView alloc] initWithFrame:CGRectMake(0, _toolbarHeight, width, 200)];
    chatFaceView.delegate=self;
    [self addSubview:chatFaceView];
}


#pragma 收回键盘并将更多、表情恢复为初始状态
-(void)hiden
{
    [self unselectedBtn];
    [textView resignFirstResponder];
    [chatMoreView removeFromSuperview];
    [chatFaceView removeFromSuperview];
    moreButton.selected=NO;
    faceButton.selected=NO;
}

#pragma mark 将更多、表情按钮恢复为初始状态
-(void)unselectedBtn{
    
    [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
    [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
    [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
}

#pragma mark 语音按钮操作
-(void)voiceButtonDown:(UIButton*)btn{
    
    [self unselectedBtn];

    //点击语音按钮
    if(!voiceButton.selected){
        
        [textView resignFirstResponder];
        [voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        
        
        textView.hidden=YES;
        talkButton.hidden=NO;
        voiceButton.selected=YES;
        [chatMoreView removeFromSuperview];
        
        if(_delegate&&[_delegate respondsToSelector:@selector(chatToolbarHeight:)]){
            
            [_delegate chatToolbarHeight:49-_toolbarHeight];
        }

    }
    else{
        
        textView.hidden=NO;
        talkButton.hidden=YES;
        [textView becomeFirstResponder];
    }
}

#pragma mark 表情按钮操作
-(void)faceButtonDown:(UIButton*)btn{
    
    if(!faceButton.selected){
        
        [faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        
        [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        
        [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        
        
        [textView resignFirstResponder];
        talkButton.hidden=YES;
        textView.hidden=NO;
        
        moreButton.selected=NO;
        voiceButton.selected=NO;
        faceButton.selected=YES;
        [chatMoreView removeFromSuperview];
        
        [self chatFaceView];
        
        if(_delegate&&[_delegate respondsToSelector:@selector(chatToolbarHeight:)]){
            
            [_delegate chatToolbarHeight:200];
        }
        
    }else{
        
        [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        talkButton.hidden=YES;
        textView.hidden=NO;
        [textView becomeFirstResponder];
        [chatFaceView removeFromSuperview];
        faceButton.selected=NO;
        
        
    }
}

#pragma mark 更多按钮操作
-(void)moreButtonDown:(UIButton*)btn{
    
    if(!moreButton.selected){
        
        [moreButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [moreButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        
        [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        
        [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        
        [textView resignFirstResponder];
        talkButton.hidden=YES;
        textView.hidden=NO;

        moreButton.selected=YES;
        voiceButton.selected=NO;
        faceButton.selected=NO;
        [chatFaceView removeFromSuperview];
        [self chatMoreView];

        if(_delegate&&[_delegate respondsToSelector:@selector(chatToolbarHeight:)]){
            
            [_delegate chatToolbarHeight:110];
        }
        
    }else{
        
        [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        [chatMoreView removeFromSuperview];
        talkButton.hidden=YES;
        textView.hidden=NO;
        [textView becomeFirstResponder];
        moreButton.selected=NO;
    }
}

#pragma mark 聊天键盘按钮操作
- (void)talkButtonDown:(UIButton *)sender
{
    [talkButton setTitle:@"松开 结束" forState:UIControlStateNormal];
    [talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateNormal];
    self.voicestate=startVoice;

    if(_delegate&&[_delegate respondsToSelector:@selector(chatDidchangeRecordStatus:)]){
        
        [_delegate chatDidchangeRecordStatus:self.voicestate];
    }
    
}

- (void)talkButtonUpInside:(UIButton *)sender
{
    [talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    self.voicestate=endVoice;

    if(_delegate&&[_delegate respondsToSelector:@selector(chatDidchangeRecordStatus:)]){
        
        [_delegate chatDidchangeRecordStatus:self.voicestate];
    }
}

- (void) talkButtonUpOutside:(UIButton *)sender
{
    [talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    self.voicestate=endVoice;

    if(_delegate&&[_delegate respondsToSelector:@selector(chatDidchangeRecordStatus:)]){
        
        [_delegate chatDidchangeRecordStatus:self.voicestate];
    }
}

#pragma mark - UITextViewDelegate
- (void) textViewDidBeginEditing:(UITextView *)textView
{

    [self unselectedBtn];
    [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
    [voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
   
    voiceButton.selected=NO;
    moreButton.selected=NO;
    faceButton.selected=NO;
    [chatFaceView removeFromSuperview];
    [chatMoreView removeFromSuperview];
    
    self.type=inputText;


    NSLog(@"chlick voiceButton");

}

- (void)textViewDidChange:(UITextView *)textView
{
    
    CGFloat height = [textView sizeThatFits:CGSizeMake(textView.frameWidth, MAXFLOAT)].height;
    
    
    height=height>MAX_TEXTVIEW_HEIGHT? MAX_TEXTVIEW_HEIGHT:height;
    

    _toolbarHeight =height+14;
    
    
    [UIView animateWithDuration:0.05 animations:^{
        
        toolView.frame=CGRectMake(0, 0, SCREEN_WIDTH, _toolbarHeight);
        textView.frame=CGRectMake(42, 7, width-126, height);
        chatMoreView.frame=CGRectMake(0, _toolbarHeight, SCREEN_WIDTH, 110);
        chatFaceView.frame=CGRectMake(0, _toolbarHeight, SCREEN_WIDTH, 200);
        
        if(_delegate&&[_delegate respondsToSelector:@selector(chatToolbardidchangeHeight:type:)]){
                
            [_delegate chatToolbardidchangeHeight:_toolbarHeight type:self.type];
            
        }
    }];

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentMessage];
        return NO;
    }
    
    return YES;
}

#pragma mark chatfacedelegate
//删除文本上的emoji
-(void)chatFaceViewDeleteButtonDown{
    
    NSString *chatText = textView.text;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    if(chatText.length>0){
        
        NSInteger length = 1;
        
        if(chatText.length>=2){
            
            NSString *subStr = [chatText substringFromIndex:chatText.length-2];
            
            if([self stringContainsEmoji:subStr]){
                
                length=2;
            }
        }
        
        textView.attributedText = [self backspaceText:attr length:length];
    }
    
    [self textViewDidChange:textView];
}

//发送富文本
-(void)chatFaceViewSendButtonDown{
    
    if (textView.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:)]) {
            [_delegate sendMessage:textView.attributedText];
        }
    }
    _type=inputEmoji;
    [textView setText:@""];
    [self textViewDidChange:textView];
}
//在文本上新增emoji
-(void)chatFaceViewDidSelectedFace:(ChatFace *)face{
    
    self.type=inputEmoji;

    
    NSMutableAttributedString * attr =[[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    NSRange range = [textView selectedRange];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:face.faceName];
    // 设置图片大小
    attch.bounds =CGRectMake(0, -5, 20, 20);
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attr insertAttributedString:string atIndex:range.location];
    
    [attr addAttribute:NSFontAttributeName value:textView.font range:NSMakeRange(0, attr.length)];
    
    textView.attributedText=attr;
    
    [self textViewDidChange:textView];
    
}

//纯文本
-(void)sendCurrentMessage{
    
    
    if (textView.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:)]) {
            [_delegate  sendMessage:textView.attributedText];
        }
    }
    [textView setText:@""];
    [self textViewDidChange:textView];
}

#pragma mark private
-(NSMutableAttributedString*)backspaceText:(NSMutableAttributedString*) attr length:(NSInteger)length
{
    NSRange range = [textView selectedRange];
    if (range.location == 0) {
        return attr;
    }
    [attr deleteCharactersInRange:NSMakeRange(range.location - length, length)];
    return attr;
}
-(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

@end
