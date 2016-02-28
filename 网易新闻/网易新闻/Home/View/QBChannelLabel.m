//
//  QBChanelLabel.m
//  网易新闻
//
//  Created by bing on 16/2/28.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "QBChannelLabel.h"
#define QBBigFont 18.f
#define QBNormalFont 14.f

@implementation QBChannelLabel

+ (instancetype)chanelLabelWithTitle:(NSString *)title {
    
    QBChannelLabel *label = [[self alloc] init];
    // 设置标题
    label.text = title;
    // 设置最大的字体
    label.font = [UIFont systemFontOfSize:QBBigFont];
    // 算出大小
    [label sizeToFit];
    // 设置默认的字体
    label.font = [UIFont systemFontOfSize:QBNormalFont];
    
    label.userInteractionEnabled = YES;
    
    return label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"%@",self.text);
    if (self.clickChannel) {
        
        self.clickChannel();
    }
}
@end
