//
//  CZHeadLineCell.m
//  09News
//
//  Created by gzxzmac on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBHeadLineCell.h"
#import "QBHeadLineModel.h"
#import <UIImageView+WebCache.h>

@interface QBHeadLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation QBHeadLineCell

- (void)setHeadLine:(QBHeadLineModel *)headLine {
    
    _headLine = headLine;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:headLine.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
}
@end
