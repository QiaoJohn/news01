//
//  QBChannelNewsCell.h
//  网易新闻
//
//  Created by bing on 16/2/28.
//  Copyright © 2016年 bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBChannelModel;
@interface QBChannelNewsCell : UICollectionViewCell
/**
 *  频道
 */
@property (nonatomic, strong) QBChannelModel *channel;
@end
