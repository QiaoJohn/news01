//
//  QBChanelLabel.h
//  网易新闻
//
//  Created by bing on 16/2/28.
//  Copyright © 2016年 bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBChannelLabel : UILabel
+ (instancetype)chanelLabelWithTitle:(NSString *)title;
@property (nonatomic, copy) void (^clickChannel)();
@property (nonatomic, assign) CGFloat scale;
@end
