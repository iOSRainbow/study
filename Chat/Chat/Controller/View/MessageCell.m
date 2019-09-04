//
//  MessageCell.m
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageBackgroundImageView];
        [self addSubview:self.avatarImageView];
    }
    
    return  self;
}


-(void)layoutSubviews
{
 
    [super layoutSubviews];
    if (_recevie.ownerTyper == MessageOwnerTypeSelf) {
        
        self.avatarImageView.frame=CGRectMake(SCREEN_WIDTH-50, 10, 40, 40);
        
    }
    else if (_recevie.ownerTyper == MessageOwnerTypeOther) {
        
        self.avatarImageView.frame=CGRectMake(10, 10, 40, 40);
        
    }
}

-(void)setRecevie:(Receive *)recevie
{
    
    _recevie = recevie;
    
    
    switch (_recevie.ownerTyper) {
        case MessageOwnerTypeSelf:
            
            /**
             *  自己发的消息
             */
            [self.avatarImageView setHidden:NO];
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_recevie.portrait] placeholderImage:nil];
            [self.messageBackgroundImageView setHidden:NO];
            /**
             *  UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
             UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
             比如下面方法中的拉伸区域：UIEdgeInsetsMake(28, 20, 15, 20)
             */
            
            self.messageBackgroundImageView.image = [[UIImage imageNamed:@"message_sender_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            
            // 设置高亮图片
            self.messageBackgroundImageView.highlightedImage = [[UIImage imageNamed:@"message_sender_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            break;
            
        case MessageOwnerTypeOther:
            /**
             *  自己接收到的消息
             */
            [self.avatarImageView setHidden:NO];
        //    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_recevie.portrait] placeholderImage:nil];
            
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_recevie.portrait] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               
                NSLog(@"image=%@",image);
                NSLog(@"error=%@",error);
            }];
            
            
            [self.messageBackgroundImageView setHidden:NO];
            [self.messageBackgroundImageView setImage:[[UIImage imageNamed:@"message_receiver_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];
            self.messageBackgroundImageView.highlightedImage = [[UIImage imageNamed:@"message_receiver_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            
            break;
  
        default:
            
            break;
            
    }
}

/**
 * avatarImageView 头像
 */

-(UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        float imageWidth = 40;
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
        _avatarImageView.layer.cornerRadius=20;
        _avatarImageView.layer.masksToBounds=YES;
        [_avatarImageView setHidden:YES];
    }
    return _avatarImageView;
}
/**
 *  聊天背景图
 */
- (UIImageView *) messageBackgroundImageView
{
    if (_messageBackgroundImageView == nil) {
        _messageBackgroundImageView = [[UIImageView alloc] init];
        [_messageBackgroundImageView setHidden:YES];
    }
    return _messageBackgroundImageView;
}


@end
