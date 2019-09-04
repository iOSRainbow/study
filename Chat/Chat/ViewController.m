//
//  ViewController.m
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title=@"聊天";
    
    keyboardRect=CGRectZero;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 键盘的Frame值即将发生变化的时候创建的额监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
  
    kddmessageView=[[KddMessageController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    kddmessageView.delegate=self;
    [self.view addSubview:kddmessageView];
    
    chatToolbar=[[ChatToolbar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, SCREEN_HEIGHT)];
    chatToolbar.delegate=self;
    [self.view addSubview:chatToolbar];
    
}

#pragma mark record view
-(void)chatRecordView{
    
    [chatRecordView removeFromSuperview];
    chatRecordView=[[ChatRecordView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2,(SCREEN_HEIGHT-100)/2, 100, 100)];
    [self.view addSubview:chatRecordView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark KddMessageControllerDelegate
-(void)didTapChatMessageView{
    
    [chatToolbar hiden];
     kddmessageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-chatToolbar.toolbarHeight);
    kddmessageView.tableview.frame=CGRectMake(0, 0, SCREEN_WIDTH, kddmessageView.frame.size.height);
     chatToolbar.frame=CGRectMake(0, SCREEN_HEIGHT-chatToolbar.toolbarHeight,SCREEN_WIDTH, SCREEN_HEIGHT);
    [kddmessageView scrollToBottom];
}

#pragma mark ChatToolbarDelegate
-(void)chatToolbarHeight:(CGFloat)height{
    
    kddmessageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-height-chatToolbar.toolbarHeight);
    kddmessageView.tableview.frame=CGRectMake(0, 0, SCREEN_WIDTH, kddmessageView.frame.size.height);

    chatToolbar.frame=CGRectMake(0, SCREEN_HEIGHT-height-chatToolbar.toolbarHeight,SCREEN_WIDTH, SCREEN_HEIGHT);
    [kddmessageView scrollToBottom];

}
-(void)chatToolbardidchangeHeight:(CGFloat)height type:(inputType)type{
    
    CGFloat y = type==inputEmoji?200:keyboardRect.size.height;
    
    kddmessageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-height-y);
    kddmessageView.tableview.frame=CGRectMake(0, 0, SCREEN_WIDTH, kddmessageView.frame.size.height);

    chatToolbar.frame=CGRectMake(0, SCREEN_HEIGHT-height-y,SCREEN_WIDTH, SCREEN_HEIGHT);
    [kddmessageView scrollToBottom];

}
-(void)chatDidchangeRecordStatus:(voiceStatus)state{
    
    if(state==startVoice){
        
        [self chatRecordView];

    }else{
        
        [chatRecordView recordButtonTouchUpInside];
    }
}
-(void)sendMessage:(NSAttributedString *)textMessage{
    
    Receive *message = [[Receive alloc] init];
    message.messageType = MessageTypeText;
    message.ownerTyper = MessageOwnerTypeSelf;
    message.attrText = textMessage;
    message.nickName=@"路人甲";
    message.portrait=@"http://218.90.187.218:8888/upload/img/advert/20180601/28094454e93e48d2a01d84c20a9bcdf4.jpg";
    [kddmessageView addNewMessage:message];

    
    Receive *recMessage = [[Receive alloc] init];
    recMessage.messageType = MessageTypeText;
    recMessage.ownerTyper = MessageOwnerTypeOther;
    NSAttributedString * str =[[NSAttributedString alloc] initWithString:@"大家好，我是路人乙，很高兴加入群"];
    recMessage.attrText = str;
    recMessage.nickName = @"路人乙";
    recMessage.portrait=@"http://218.90.187.218:8888/upload/img/advert/20180601/80727a9ce54f461d8741f5aa5928c4f1.jpg";
    [kddmessageView addNewMessage:recMessage];
    
    
    Receive *recMessage1 = [[Receive alloc] init];
    recMessage1.messageType =MessageTypeImage;
    recMessage1.ownerTyper = MessageOwnerTypeOther;
    recMessage1.imageURL = @"http://218.90.187.218:8888/upload/img/viewspot/viewspotalumpic/logo/1517978961658690.png";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:recMessage1.imageURL]];
    UIImage *image = [UIImage imageWithData:data];
    recMessage1.rate_width=image.size.width;
    recMessage1.rate_height=image.size.height;
    recMessage1.nickName = @"路人丙";
    recMessage1.portrait=@"http://218.90.187.218:8888/upload/img/advert/20180504/188074a133774e3ab191f633a26ab84c.jpg";
    [kddmessageView addNewMessage:recMessage1];
    
    
    Receive *recMessage2 = [[Receive alloc] init];
    recMessage2.messageType = MessageTypeImage;
    recMessage2.ownerTyper = MessageOwnerTypeOther;
    recMessage2.imageURL = @"http://218.90.187.218:8888/upload/img/viewspot/viewspotalumpic/logo/1522114713276690.png";
    NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:recMessage2.imageURL]];
    UIImage *image1 = [UIImage imageWithData:data1];
    recMessage2.rate_width=image1.size.width;
    recMessage2.rate_height=image1.size.height;
    recMessage2.nickName = @"路人丁";
    recMessage2.portrait=@"http://218.90.187.218:8888/upload/img/advert/1517970870778940.jpg";
    [kddmessageView addNewMessage:recMessage2];
    
    
    Receive *recMessage3 = [[Receive alloc] init];
    recMessage3.messageType = MessageTypeText;
    recMessage3.ownerTyper = MessageOwnerTypeSelf;
    recMessage3.attrText = [[NSAttributedString alloc] initWithString:@"欢迎"];
    recMessage3.nickName=@"路人甲";
    recMessage3.portrait=@"http://218.90.187.218:8888/upload/img/advert/20180601/28094454e93e48d2a01d84c20a9bcdf4.jpg";
    [kddmessageView addNewMessage:recMessage3];
    
    
    Receive *recMessage4 = [[Receive alloc] init];
    recMessage4.messageType = MessageTypeImage;
    recMessage4.ownerTyper = MessageOwnerTypeOther;
    recMessage4.imageURL = @"http://218.90.187.218:8888/upload/img/food/food/1520823018483310.jpg";
    NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:recMessage4.imageURL]];
    UIImage *image2 = [UIImage imageWithData:data2];
    recMessage2.rate_width=image2.size.width;
    recMessage2.rate_height=image2.size.height;
    recMessage4.nickName = @"路人王";
    recMessage4.portrait=@"http://218.90.187.218:8888/upload/img/hotel/20180321/80fa8819ce65436e86e8a9126937fb87.jpg";
    [kddmessageView addNewMessage:recMessage4];
    
    
    Receive *recMessage5 = [[Receive alloc] init];
    recMessage5.messageType = MessageTypeImage;
    recMessage5.ownerTyper = MessageOwnerTypeSelf;
    recMessage5.imageURL = @"http://218.90.187.218:8888/upload/img/food/food/1517459986099320.jpg";
    NSData *data3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:recMessage5.imageURL]];
    UIImage *image3 = [UIImage imageWithData:data3];
    recMessage5.rate_width=image3.size.width;
    recMessage5.rate_height=image3.size.height;
    recMessage5.nickName=@"路人甲";
    recMessage5.portrait=@"http://218.90.187.218:8888/upload/img/advert/20180601/28094454e93e48d2a01d84c20a9bcdf4.jpg";
    [kddmessageView addNewMessage:recMessage5];
    
    
    /**
     *  滚动插入的消息，使他始终处于一个可以看得见的位置
     */
    [kddmessageView scrollToBottom];
}

#pragma mark 监听键盘高度
- (void)keyboardWillHide:(NSNotification *)notification{
 
}
- (void)keyboardFrameWillChange:(NSNotification *)notification{

    keyboardRect  = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]; 
    
    kddmessageView.frame=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT -chatToolbar.toolbarHeight-keyboardRect.size.height);
    kddmessageView.tableview.frame=CGRectMake(0, 0, SCREEN_WIDTH, kddmessageView.frame.size.height);


    chatToolbar.frame=CGRectMake(0, SCREEN_HEIGHT-keyboardRect.size.height-chatToolbar.toolbarHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [kddmessageView scrollToBottom];

    
}
- (void)dealloc{
    
    /**
     *  移除键盘通知
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
