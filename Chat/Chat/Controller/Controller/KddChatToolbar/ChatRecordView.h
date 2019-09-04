//
//  ChatRecordView.h
//  Chat
//
//  Created by 李世飞 on 2018/6/12.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ChatRecordView : UIView
{
    
    NSArray * imageArray;
    UIImageView * recordAnimationView;
    NSTimer *timer;
    AVAudioRecorder *recorder;
    
}

-(void)recordButtonTouchUpInside;
@end
