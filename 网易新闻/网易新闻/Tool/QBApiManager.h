//
//  QBApiManager.h
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBApiManager : NSObject
+ (instancetype)sharedApi;
/**
 *  请求头条的广告数据
 *
 *  @param url     请求路径
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)requestHeadLineDataWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error;

- (void)requestNewsDataWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error;
@end
