//
//  CZHeadLineController.m
//  09News
//
//  Created by gzxzmac on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBHeadLineController.h"
#import "QBHeadLineCell.h"
#import "QBHeadLineModel.h"
#import "QBApiManager.h"
#define QBGroupCount 10000
@interface QBHeadLineController ()<UICollectionViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *data;

@end

@implementation QBHeadLineController

static NSString * const reuseIdentifier = @"HeadLine";

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    // 设置背景
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 设置item大小
    self.layout.itemSize = self.collectionView.bounds.size;
    // 滚动方向
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 设置间隔
    self.layout.minimumLineSpacing = 0;
    // 设置分页
    self.collectionView.pagingEnabled = YES;
    //关闭弹簧
    self.collectionView.bounces = NO;
}


/**
 *   加载头条数据
 */
- (void)loadData {
    
    [QBHeadLineModel headLineDatasWithURL:@"ad/headline/0-4.html" success:^(NSArray *headLines) {
        // NSLog(@"%@",headLines);
        self.data = headLines;
        
        [self.collectionView reloadData];
        // 设置分页
        self.pageControl.numberOfPages = self.data.count;
        // 设置第一页的标题
        [self scrollViewDidEndDecelerating:self.collectionView];
    }];
}

// 使用多个组实现无限循环
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return QBGroupCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QBHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 设置分页
    cell.tag = indexPath.item;
    // 设置数据
    cell.headLine = self.data[indexPath.item];
    
    return cell;
}

// 在滚动结束的时候判断一下之前是第几张
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = (NSInteger)(self.collectionView.contentOffset.x / scrollView.bounds.size.width )% self.data.count;
    
    // 取出当前页的模型
    QBHeadLineModel *headLine = self.data[index];
    // 设置标题
    self.titleLabel.text = headLine.title;
    // 设置当前第几页
    self.pageControl.currentPage = index;
}

@end
