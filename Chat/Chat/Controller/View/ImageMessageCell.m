//
//  ImageMessageCell.m
//  Chat
//
//  Created by 李世飞 on 2018/6/11.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ImageMessageCell.h"

@implementation ImageMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
   
        [self.messageBackgroundImageView addSubview:self.messageImageView];
    
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat height =self.recevie.cellHeight;

   
    if (self.recevie.ownerTyper == MessageOwnerTypeSelf) {
       
        self.messageBackgroundImageView.frame=CGRectMake(SCREEN_WIDTH-80-self.recevie.messageSize.width, 10, self.recevie.messageSize.width+20, height-20);

    }
    else if (self.recevie.ownerTyper == MessageOwnerTypeOther) {
       
        self.messageBackgroundImageView.frame=CGRectMake(55,10, self.recevie.messageSize.width+20, height-20);

    }
    self.messageImageView.frame=CGRectMake(10, 10, self.recevie.messageSize.width, self.recevie.messageSize.height);

}

#pragma mark - Getter and Setter
-(void)setRecevie:(Receive *)recevie
{
    [super setRecevie:recevie];
   
    [self.messageImageView sd_setImageWithURL:[NSURL URLWithString:recevie.imageURL] placeholderImage:nil];

}

- (UIImageView *) messageImageView
{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc] init];
        [_messageImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_messageImageView setClipsToBounds:YES];
    }
    return _messageImageView;
}
@end
