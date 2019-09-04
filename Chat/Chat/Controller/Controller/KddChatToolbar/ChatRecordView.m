//
//  ChatRecordView.m
//  Chat
//
//  Created by 李世飞 on 2018/6/12.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ChatRecordView.h"

#define MS_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

@implementation ChatRecordView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width=frame.size.width;
        CGFloat height=frame.size.height;
        
        
    imageArray=@[@"VoiceSearchFeedback001",@"VoiceSearchFeedback002",@"VoiceSearchFeedback003",@"VoiceSearchFeedback004",@"VoiceSearchFeedback005",@"VoiceSearchFeedback006",@"VoiceSearchFeedback007",@"VoiceSearchFeedback008",@"VoiceSearchFeedback009",@"VoiceSearchFeedback010",@"VoiceSearchFeedback011",@"VoiceSearchFeedback012",@"VoiceSearchFeedback013",@"VoiceSearchFeedback014",@"VoiceSearchFeedback015",@"VoiceSearchFeedback016",@"VoiceSearchFeedback017",@"VoiceSearchFeedback018",@"VoiceSearchFeedback019"];
        
        UIView * backView= [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor=MS_RGBA(0, 0, 0, 0.6);
        backView.layer.cornerRadius=5;
        backView.layer.masksToBounds=YES;
        [self addSubview:backView];
        
        recordAnimationView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width-20, height-20)];
        recordAnimationView.image=[UIImage imageNamed:@"VoiceSearchFeedback001"];
        recordAnimationView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:recordAnimationView];
        
        
        
        
        NSError *error = nil;
        int x = arc4random() % 100000;
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
        
        NSString *recordPath = [NSString stringWithFormat:@"%@/%@", [self dataPath], fileName];

        
        NSString *wavFilePath = [[recordPath stringByDeletingPathExtension]
                                 stringByAppendingPathExtension:@"wav"];
        NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:wavFilePath];
        
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                          [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                          [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                          [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                          nil];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:wavUrl
                                                settings:dic
                                                   error:&error];
        
        
        NSLog(@"wavFilePath===%@",wavFilePath);
        NSLog(@"error===%@",error);
        recorder.meteringEnabled=YES;
        [recorder record];

        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(setVoiceImage)
                                                userInfo:nil
                                                 repeats:YES];
    
    }
 
    return self;
}


-(void)setVoiceImage {
    
    recordAnimationView.image = [UIImage imageNamed:[imageArray objectAtIndex:0]];
    double voiceSound = 0;
    voiceSound=[self emPeekRecorderVoiceMeter];
    NSInteger index = voiceSound*[imageArray count];
    
    if (index >= [imageArray count]) {
        recordAnimationView.image = [UIImage imageNamed:[imageArray lastObject]];
    } else {
        recordAnimationView.image = [UIImage imageNamed:[imageArray objectAtIndex:index]];
    }
}



// 获取录制音频时的音量(0~1)
- (double)emPeekRecorderVoiceMeter{
    double ret = 0.0;
    if (recorder.isRecording) {
        [recorder updateMeters];
        double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
        ret = lowPassResults;
    }
    return ret;
}

-(void)recordButtonTouchUpInside{
    
    timer=nil;
    [timer invalidate];
    [recorder stop];
    recorder=nil;
    [self removeFromSuperview];
}

-(NSString*)dataPath
{
    NSString *dataPath = [NSString stringWithFormat:@"%@/Library/appdata/chatbuffer", NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dataPath]){
        [fm createDirectoryAtPath:dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    return dataPath;
}
@end
