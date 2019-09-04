//
//  Receive.m
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "Receive.h"

static UILabel *label = nil;



@implementation Receive



-(id)init
{
    if (self = [super init]) {
        
        if (label == nil) {
            label = [[UILabel alloc] init];
            [label setNumberOfLines:0];
            [label setFont:[UIFont systemFontOfSize:16.0f]];
        }
    }
    
    return self;
}



#pragma mark - Getter
- (void) setMessageType:(MessageType)messageType
{
    
    _messageType = messageType;
    switch (messageType) {
        case MessageTypeText:
            self.cellIndentify = @"TextMessageCell";
            break;
            
          case MessageTypeImage:
            self.cellIndentify=@"ImageMessageCell";
            break;
            
        default:
            break;
    }
}


-(CGSize) messageSize
{
    
    switch (self.messageType) {
            
        case MessageTypeText:
            [label setAttributedText:self.attrText];
            _messageSize = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH * 0.58, MAXFLOAT)];
            break;
            
         case MessageTypeImage:
            
            //如果 width= height 说明是正方形
            if(self.rate_width==self.rate_height){
                
                _messageSize=CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);
            }
            
            else if (self.rate_width>self.rate_height){
                
                _messageSize=CGSizeMake(SCREEN_WIDTH/2, ((SCREEN_WIDTH/2)*self.rate_height)/self.rate_width);
            }
            else {
                
                _messageSize=CGSizeMake(SCREEN_WIDTH*0.4, ((SCREEN_WIDTH*0.4)*self.rate_height)/self.rate_width);
            }
            break;
    
        default:
            break;
    }
    
    return _messageSize;
}


-(CGFloat) cellHeight
{
    
    switch (self.messageType){
            // cell 上下间隔为10
        case MessageTypeText:
            
            return self.messageSize.height + 40 > 60 ? self.messageSize.height + 40 : 60;
            break;
            
         case MessageTypeImage:
            
            return self.messageSize.height+40;
            
            break;
   
        default:
            
            break;
    }

    return 0;
}


@end
