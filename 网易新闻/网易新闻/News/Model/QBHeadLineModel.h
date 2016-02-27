//
//  QBHeadLineModel.h
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBHeadLineModel : NSObject
/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)headLineWithDict:(NSDictionary *)dict;

/**
 *  加载头条数据
 */
+ (void)headLineDatasWithURL:(NSString *)url success:(void(^)(NSArray *headLines))success;
@end
