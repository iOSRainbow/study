//
//  ChatMoreView.m
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ChatMoreView.h"

@implementation ChatMoreView



-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        KPageCount = 4;
        KPageSection=1;
        
        CGFloat width =SCREEN_WIDTH;
        CGFloat height=frame.size.height;

        NSArray * ary =@[@"sharemore_pic",@"sharemore_video",@"sharemore_location"];
        NSArray * titleAray =@[@"图片",@"拍照",@"位置"];
        
        scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,width,height)];
        scr.backgroundColor=[UIColor whiteColor];
        scr.contentSize=CGSizeMake(0,height);
        scr.showsHorizontalScrollIndicator=NO;
        scr.showsVerticalScrollIndicator=NO;
        [self addSubview:scr];
        
        UIView * topLine=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
        topLine.backgroundColor=[UIColor grayColor];
        [self addSubview:topLine];
        
        CGFloat itemBtnW = width/(KPageCount/KPageSection);
        CGFloat itemBtnH = height/KPageSection;
        for(int i=0;i<ary.count;i++){
            
            CGFloat itemBtnX = i/KPageCount *width + (i%(KPageCount/KPageSection))*itemBtnW;
            
            CGFloat itemBtnY = ((i - (i/KPageCount)*KPageCount)/(KPageCount/KPageSection))*itemBtnH;
            
            
            UIView * view =[[UIView alloc] initWithFrame:CGRectMake(itemBtnX, itemBtnY, itemBtnW, itemBtnH)];
            [scr addSubview:view];
            
            
            UIView * imgView =[[UIView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
            imgView.layer.masksToBounds=YES;
            imgView.layer.cornerRadius=4;
            imgView.layer.borderWidth=0.5;
            imgView.layer.borderColor=[[UIColor grayColor] CGColor];
            [view addSubview:imgView];
            
            UIImageView * img =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,60, 60)];
            img.image=[UIImage imageNamed:ary[i]];
           [imgView addSubview:img];
            
            UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(10, 80, view.frame.size.width-20, 20)];
            lable.textColor=[UIColor grayColor];
            lable.font=[UIFont systemFontOfSize:14];
            lable.text=titleAray[i];
            lable.textAlignment=1;
            [view addSubview:lable];
            
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            btn.tag=i;
            [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }

    }
    return self;
}

-(void)Action:(UIButton*)btn{
    
}
@end
