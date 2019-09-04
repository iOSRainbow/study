//
//  ViewController.h
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatToolbar.h"
#import "define.h"
#import "KddMessageController.h"
#import "ChatRecordView.h"

@interface ViewController : UIViewController<ChatToolbarDelegate,KddMessageControllerDelegate>
{
    
    ChatToolbar * chatToolbar;
    KddMessageController * kddmessageView;
    ChatRecordView * chatRecordView;

    CGRect  keyboardRect;
    
}

@end

