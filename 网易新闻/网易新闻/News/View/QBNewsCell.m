//
//  QBNewsCell.m
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBNewsCell.h"
#import "QBNewsModel.h"
#import <UIImageView+WebCache.h>
#import "QBNewsImageModel.h"

@interface QBNewsCell ()
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *digestLabel;
@property (nonatomic, weak) IBOutlet UILabel *replyCountLabel;
/**
 *  多张视图
 */
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextra;
@end

@implementation QBNewsCell

- (void)setNews:(QBNewsModel *)news {
    
    _news = news;
    // 设置图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    // 设置标题
    self.titleLabel.text = news.title;
    // 设置简介
    self.digestLabel.text = news.digest;
    // 设置跟帖数
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@人跟帖",news.replyCount];
    
    // 判断有没有更多图片
    if (_news.imgextra != nil) {
        
        [self.imgextra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 取出对应的图片
            QBNewsImageModel *model = _news.imgextra[idx];
            
            [obj sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
        }];
    }
}

+ (NSString *)cellIdentiferWithNews:(QBNewsModel *)news {
    
    if (news.imgextra != nil) {
        
        return @"QBNewsMoreImageCell";
        
    } else if (news.imgType == 1) {
        
        return @"QBNewsBigImageCell";
        
    } else {
        
        return @"QBNewsCell";
    }
}

+ (CGFloat)cellHeightWithNews:(QBNewsModel *)news {
    
    if (news.imgextra != nil) {
        
        return 100;
        
    } else if (news.imgType == 1) {
        
        return 150;
        
    } else {
        return 80;
    }
}
@end
