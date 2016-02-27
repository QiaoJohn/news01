//
//  QBNewsCell.h
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBNewsModel;
@interface QBNewsCell : UITableViewCell
@property (nonatomic, strong) QBNewsModel *news;
+ (CGFloat)cellHeightWithNews:(QBNewsModel *)news;
+ (NSString *)cellIdentiferWithNews:(QBNewsModel *)news;
@end
