//
//  QBHomeController.m
//  网易新闻
//
//  Created by bing on 16/2/28.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "QBHomeController.h"
#import "QBChannelModel.h"
#import "QBChannelLabel.h"
#import "QBChannelNewsCell.h"

@interface QBHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *channels;// 频道数
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setupView];
    
}
/**
 *  设置view的布局以及其他的样式
 */
- (void)setupView {
    
    // 设置背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 设置item 大小
    self.layout.itemSize = self.collectionView.bounds.size;
    // 滚动方向
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 设置间隔
    self.layout.minimumLineSpacing = 0;
    // 设置分页
    self.collectionView.pagingEnabled = YES;
    // 关闭弹簧
    self.collectionView.bounces = NO;
    
}


- (void)loadData {
    
    NSArray *chanels = [QBChannelModel chanelDatas];
    
    // NSLog(@"%@",chanels);
    // 排序
    chanels = [chanels sortedArrayUsingComparator:^NSComparisonResult(QBChannelModel * _Nonnull obj1, QBChannelModel * _Nonnull obj2) {
        
        return [obj1.tid compare:obj2.tid];
    }];
    
    __block CGFloat labelX = 0;
    
    [chanels enumerateObjectsUsingBlock:^(QBChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 算坐标
        CGFloat labelY = 0;
        CGFloat labelH = self.scrollView.bounds.size.height;
        
        QBChannelLabel *label = [QBChannelLabel chanelLabelWithTitle:obj.tname];
        
        CGFloat labelW = label.bounds.size.width;
        // 设置frame
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        labelX += labelW;
        
        // 添加到scrowView
        [self.scrollView addSubview:label];
    }];
    
    // 设置范围
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    
    self.channels = chanels;
    [self.collectionView reloadData];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QBChannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QBChannelNewsCell" forIndexPath:indexPath];
    
    
    QBChannelModel *channel = self.channels[indexPath.item];
    cell.channel = channel;
    
    //cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return cell;
}
@end
