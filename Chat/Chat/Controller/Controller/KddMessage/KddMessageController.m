//
//  KddMessageController.m
//  Chat
//
//  Created by 李世飞 on 2018/6/8.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "KddMessageController.h"


@implementation KddMessageController

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        dataArray=[[NSMutableArray alloc] init];
        
        _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,frame.size.height) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.showsHorizontalScrollIndicator=NO;
        
        [self addSubview:_tableview];
        
        
        UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiden)];
        singleRecognizer.numberOfTapsRequired = 1;
        [_tableview addGestureRecognizer:singleRecognizer];
        
        /**
         *  注册四个 cell
         */
        [_tableview registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
        [_tableview registerClass:[TextMessageCell class] forCellReuseIdentifier:@"TextMessageCell"];
        [_tableview registerClass:[ImageMessageCell class] forCellReuseIdentifier:@"ImageMessageCell"];

    }
    return self;
}



-(void)hiden{
    
    if(_delegate&&[_delegate respondsToSelector:@selector(didTapChatMessageView)]){
        
        [_delegate didTapChatMessageView];
    }
}

- (void) addNewMessage:(Receive *)message
{
    /**
     *  数据源添加一条消息，刷新数据
     */
    [dataArray addObject:message];
    [_tableview reloadData];
    
}

- (void) scrollToBottom
{
    if (dataArray.count > 0) {
        // tableView 定位到的cell 滚动到相应的位置，后面的 atScrollPosition 是一个枚举类型
        [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Receive  * messageModel = dataArray[indexPath.row];
    /**
     *  id类型的cell 通过取出来Model的类型，判断要显示哪一种类型的cell
     */
    id cell = [tableView dequeueReusableCellWithIdentifier:messageModel.cellIndentify forIndexPath:indexPath];
    // 给cell赋值
    [cell setRecevie:messageModel];
    return cell;
}


#pragma mark - UITableViewCellDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Receive *message = [dataArray objectAtIndex:indexPath.row];
    return message.cellHeight;
}



@end
