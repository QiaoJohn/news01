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
#import "QBNewsController.h"

@interface QBHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *channels;// 频道数
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableDictionary *newsVCCache;// 控制器缓存

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
        
        __weak typeof(label) weakLabel = label;
        __weak typeof(self) weakSelf = self;
        [label setClickChannel:^{
            
           // NSLog(@"%@--%zd",weakLabel.text,idx);
            
        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            
            // 切换频道
            QBChannelLabel *currentChannel = weakSelf.scrollView.subviews[self.currentPage];
            currentChannel.scale = 0;
            // 点击的变大
            weakLabel.scale = 1;
            weakSelf.currentPage = idx;
            
            [self adjScrollViewContentOffset];
           
        }];

        if (idx == 0) {
            // 默认选中第一个
            label.scale = 1;
        }
        // 添加到scrowView
        [self.scrollView addSubview:label];
    }];
    
    // 设置范围
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    
    self.channels = chanels;
    [self.collectionView reloadData];
}

- (void)adjScrollViewContentOffset {
    
    // 取出当前选中的频道
    QBChannelLabel *channel = self.scrollView.subviews[self.currentPage];
    
    CGFloat offsetX = channel.center.x - CGRectGetWidth(self.scrollView.frame) * 0.5;
    
    if (offsetX < 0) {
        // 如果点击的是前面几个标签，让scrollview滚动到初始化的位置
        offsetX = 0;
    }
    // 判断如果是最后几个，不需要offset到频道的中点
    CGFloat maxOffsetX = (self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame));
    
    if (offsetX > maxOffsetX) {
        
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QBChannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QBChannelNewsCell" forIndexPath:indexPath];
    // 把旧的View移除
    [cell.news.view removeFromSuperview];
    
    QBChannelModel *channel = self.channels[indexPath.item];
    // 取出频道对应子控制器
    QBNewsController *news = [self newsControllerWithChannel:channel];
    
    if (![self.childViewControllers containsObject:news]) {
        NSLog(@"添加子控制器");
        // 把控制器添加到子控制器，否则会影响响应者链条
        [self addChildViewController:news];
        
    }
    // 设置尺寸
    news.view.frame = cell.contentView.bounds;
    
    [cell.contentView addSubview:news.view];
    
    //cell.channel = channel;
    
    cell.news = news;
    
    return cell;
}

/**
   从缓存中加载新闻
 */
- (QBNewsController *)newsControllerWithChannel:(QBChannelModel *)channel {
    
    QBNewsController *news = [self.newsVCCache objectForKey:channel.tid];
    // 如果是nil手动初始化
    if (news == nil) {
        
        // 把新闻控制器加进来
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        
        news = [sb instantiateInitialViewController];
        
        news.channelId = channel.tid;
        
        // 添加到缓存中
        [self.newsVCCache setObject:news forKey:channel.tid];
    }
    return news;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    QBChannelLabel *currentChannel = self.scrollView.subviews[self.currentPage];
    
    __block QBChannelLabel *nextChannel;
    
    // 取出当前可视范围的collectionViewCell对应的IndexPath
    NSArray *indexPath = [self.collectionView indexPathsForVisibleItems];
    
    [indexPath enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.item != self.currentPage) {
            // 上一页/下一页
            nextChannel = self.scrollView.subviews[obj.item];
        }
        
    }];
    
    if (nextChannel == nil) {
        
        //NSLog(@"没有下一个频道");
        return;
    }
    
    // 偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat scale = ABS(offsetX / scrollView.bounds.size.width - self.currentPage); // 放大
    
    CGFloat currentScale = 1 - scale; // 缩小
    
    nextChannel.scale = scale;
    
    currentChannel.scale = currentScale;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentPage = (NSInteger)offsetX / scrollView.bounds.size.width;
    // 调整频道栏的位置
    [self adjScrollViewContentOffset];
}

- (NSMutableDictionary *)newsVCCache {
    
    if (!_newsVCCache) {
        _newsVCCache = [NSMutableDictionary dictionary];
    }
    return _newsVCCache;
}
@end
