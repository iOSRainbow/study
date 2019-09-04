//
//  TextMessageCell.m
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "TextMessageCell.h"

@implementation TextMessageCell

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
       
        [self.messageBackgroundImageView addSubview:self.messageTextLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height =self.recevie.cellHeight;
    
    if(self.recevie.ownerTyper==MessageOwnerTypeSelf){
        
        self.messageBackgroundImageView.frame=CGRectMake(SCREEN_WIDTH-10-40-10-self.recevie.messageSize.width-20, 10, self.recevie.messageSize.width+20, height-20);

    }
    else{
        
        self.messageBackgroundImageView.frame=CGRectMake(55, 10, self.recevie.messageSize.width+20, height-20);
        
    }
    
    self.messageTextLabel.frame=CGRectMake(10,(self.messageBackgroundImageView.frame.size.height-self.recevie.messageSize.height)/2, self.recevie.messageSize.width, self.recevie.messageSize.height);
    
}

#pragma mark - Getter and Setter
-(void)setRecevie:(Receive *)recevie
{
    [super setRecevie:recevie];
    [_messageTextLabel setAttributedText:recevie.attrText];
    _messageTextLabel.size = recevie.messageSize;
}

- (UILabel *) messageTextLabel
{
    if (_messageTextLabel == nil) {
        _messageTextLabel = [[UILabel alloc] init];
        [_messageTextLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_messageTextLabel setNumberOfLines:0];
    }
    return _messageTextLabel;
}


@end
