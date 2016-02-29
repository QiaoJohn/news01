//
//  QBNewsModel.h
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QBNewsImageModel;
@interface QBNewsModel : NSObject
/**
 *  跟帖数
 */
@property (nonatomic, copy) NSString *replyCount;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  简介
 *
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  更多图片
 */
@property (nonatomic, strong) NSArray<QBNewsImageModel *> *imgextra;
/**
 *  图片类型 1是大图，默认是0 ，小图
 */
@property (nonatomic, assign) NSInteger imgType;
@property (nonatomic, copy) NSString *docid;
/**
 *  新闻详情
 */
@property (nonatomic, copy) NSString *fullURL;
/**
 *  加载新闻数据
 *
 *  @param url     新闻数据的路径
 *  @param success 成功回调
 */
+ (void)newsDataWithURL:(NSString *)url success:(void (^)(NSArray *))success;
@end
