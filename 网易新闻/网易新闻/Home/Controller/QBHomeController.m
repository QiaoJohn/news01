//
//  QBHomeController.m
//  网易新闻
//
//  Created by bing on 16/2/28.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "QBHomeController.h"
#import "QBChanceModel.h"
#import "QBChanelLabel.h"

@interface QBHomeController ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end

@implementation QBHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 在导控制器下面，scrowView或者它的子类，会默认被设置了一个
    // contentInsets-->(0,64)
    // 使用一下大妈关闭默认的调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
    
    
}

- (void)loadData {
    
    NSArray *chanels = [QBChanceModel chanelDatas];
    
    // NSLog(@"%@",chanels);
    // 排序
    chanels = [chanels sortedArrayUsingComparator:^NSComparisonResult(QBChanceModel * _Nonnull obj1, QBChanceModel * _Nonnull obj2) {
        
        return [obj1.tid compare:obj2.tid];
    }];
    
    __block CGFloat labelX = 0;
    
    [chanels enumerateObjectsUsingBlock:^(QBChanceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 算坐标
        CGFloat labelY = 0;
        CGFloat labelH = self.scrollView.bounds.size.height;
        
        QBChanelLabel *label = [QBChanelLabel chanelLabelWithTitle:obj.tname];
        
        CGFloat labelW = label.bounds.size.width;
        // 设置frame
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        labelX += labelW;
        
        // 添加到scrowView
        [self.scrollView addSubview:label];
    }];
    
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    
    
}
@end
