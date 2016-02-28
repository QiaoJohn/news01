//
//  QBChannelNewsCell.m
//  网易新闻
//
//  Created by bing on 16/2/28.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "QBChannelNewsCell.h"
#import "QBChannelModel.h"
#import "QBNewsController.h"


@interface QBChannelNewsCell ()
@property (nonatomic, strong) QBNewsController *news;
@end

@implementation QBChannelNewsCell


- (void)setChannel:(QBChannelModel *)channel {
    
    _channel = channel;
    // 把新闻控制器加进来
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    QBNewsController *news = [sb instantiateInitialViewController];
    // 加载不同的新闻
    news.channelId = _channel.tid;
    // 把控制器的view添加到cell上面
    [self.contentView addSubview:news.view];
    
    // 设置frame
    news.view.frame = self.contentView.bounds;
    
    self.news = news;
}
@end
