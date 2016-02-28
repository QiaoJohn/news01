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

@interface QBNewsController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation QBNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QBNewsModel *news = self.data[indexPath.row];
    
    return [QBNewsCell cellHeightWithNews:news];
}
@end
