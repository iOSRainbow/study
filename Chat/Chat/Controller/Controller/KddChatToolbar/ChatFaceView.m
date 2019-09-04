//
//  ChatFaceView.m
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ChatFaceView.h"

@implementation ChatFaceView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        KPageCount = 21;
        KPageSection=3;
        
        [self getFaceArrayFromPlist];
        
        CGFloat width =SCREEN_WIDTH;
        CGFloat height=frame.size.height;
        
        CGFloat itemBtnW = width/(KPageCount/KPageSection);
        CGFloat itemBtnH = (height-40)/KPageSection;
        
        scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,width,height-40)];
        scr.backgroundColor=[UIColor whiteColor];
        scr.scrollEnabled=YES;
        scr.contentSize=CGSizeMake(2*width,height-40);
        scr.showsHorizontalScrollIndicator=NO;
        scr.showsVerticalScrollIndicator=NO;
        [self addSubview:scr];
        
        
        
        UIView * topLine=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
        topLine.backgroundColor=[UIColor grayColor];
        [self addSubview:topLine];
        
        
        UIView * bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, height-40, SCREEN_WIDTH, 40)];
        [self addSubview:bottomView];
        
        UIButton * sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame=CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
        sendButton.backgroundColor=[UIColor blueColor];
        [sendButton setTitle:@"发送" forState:normal];
        [sendButton setTitleColor:[UIColor whiteColor] forState:normal];
        sendButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [sendButton addTarget:self action:@selector(SendMessageAction) forControlEvents:UIControlEventTouchUpInside];

        [bottomView addSubview:sendButton];
        
        for(int i=0;i<dataArray.count;i++){
            
            ChatFace * face =dataArray[i];
            
            CGFloat itemBtnX = i/KPageCount *width + (i%(KPageCount/KPageSection))*itemBtnW;
            
            CGFloat itemBtnY = ((i - (i/KPageCount)*KPageCount)/(KPageCount/KPageSection))*itemBtnH;
            
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(itemBtnX, itemBtnY, itemBtnW, itemBtnH);
            [btn setImage:[UIImage imageNamed:face.faceName] forState:normal];
            btn.tag=i;
            [scr addSubview:btn];
            
            if(face.faceID.length==0){
                
                [btn addTarget:self action:@selector(deleteEmojiAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                
                [btn addTarget:self action:@selector(AddEmojiAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    return self;
}
-(void)deleteEmojiAction:(UIButton*)btn{
    
    if(_delegate&&[_delegate respondsToSelector:@selector(chatFaceViewDeleteButtonDown)]){
        
        [_delegate chatFaceViewDeleteButtonDown];
    }
    
}
-(void)AddEmojiAction:(UIButton*)btn{
    
    ChatFace * face =dataArray[btn.tag];
    if(_delegate&&[_delegate respondsToSelector:@selector(chatFaceViewDidSelectedFace:)]){
        
        [_delegate chatFaceViewDidSelectedFace:face];
    }

}
-(void)SendMessageAction{
    
    if(_delegate&&[_delegate respondsToSelector:@selector(chatFaceViewSendButtonDown)]){
        
        [_delegate chatFaceViewSendButtonDown];
    }
    
}
- (void) getFaceArrayFromPlist
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"normal_face" ofType:@"plist"]];
    dataArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        ChatFace *face = [[ChatFace alloc] init];
        face.faceID = [dic objectForKey:@"face_id"];
        face.faceName = [dic objectForKey:@"face_name"];
        [dataArray addObject:face];
    }
    
    
    ChatFace *face1 = [[ChatFace alloc] init];
    face1.faceID = @"";
    face1.faceName = @"DeleteEmoticonBtn";
    [dataArray insertObject:face1 atIndex:20];
    
    ChatFace *face2 = [[ChatFace alloc] init];
    face2.faceID = @"";
    face2.faceName = @"DeleteEmoticonBtn";
    [dataArray insertObject:face2 atIndex:41];
  
}
@end
