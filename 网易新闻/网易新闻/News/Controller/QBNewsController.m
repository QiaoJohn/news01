//
//  QBNewsController.m
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBNewsController.h"
#import "QBNewsModel.h"
#import "QBNewsCell.h"
#import "QBNewsDetailController.h"

@interface QBNewsController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation QBNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    
    //NSLog(@"加载频道新闻%@",self.channelId)
    ;
    [QBNewsModel newsDataWithURL:[NSString stringWithFormat:@"article/headline/%@/0-20.html",self.channelId] success:^(NSArray *news) {
        
        self.data = news;
        // 刷新tableView
        [self.tableView reloadData];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QBNewsModel *news = self.data[indexPath.row];
    
    QBNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[QBNewsCell cellIdentiferWithNews:news] forIndexPath:indexPath];
    
    // 设置模型数据
    cell.news = news;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"显示详情页");
    
    QBNewsModel *news = self.data[indexPath.row];
    // 初始化详情页控制器
    QBNewsDetailController *detail = [[QBNewsDetailController alloc]init];
    detail.newsURL = news.fullURL;
 
    // push
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出对应的模型
    QBNewsModel *news = self.data[indexPath.row];

    return [QBNewsCell cellHeightWithNews:news];
}
@end
