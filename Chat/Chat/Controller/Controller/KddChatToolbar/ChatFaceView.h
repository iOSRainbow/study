//
//  ChatFaceView.h
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatFace.h"
#import "define.h"

@protocol ChatFaceViewDelegate <NSObject>

- (void) chatFaceViewDidSelectedFace:(ChatFace *)face;
- (void) chatFaceViewDeleteButtonDown;
- (void) chatFaceViewSendButtonDown;

@end

@interface ChatFaceView : UIView
{
    UIScrollView * scr;
    UIPageControl * pageControl;
    NSMutableArray * dataArray;
    
    NSInteger KPageCount; //一页几个
    NSInteger KPageSection;//一页几行
}
@property (nonatomic, assign) id<ChatFaceViewDelegate>delegate;

@end
