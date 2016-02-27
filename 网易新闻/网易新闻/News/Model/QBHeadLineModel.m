//
//  QBHeadLineModel.m
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBHeadLineModel.h"
#import "QBApiManager.h"

@implementation QBHeadLineModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
/**
 *  防止调用 setValuesForKeysWithDictionary(KVC)造成程序崩了
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)headLineWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

+ (void)headLineDatasWithURL:(NSString *)url success:(void (^)(NSArray *))success {
    
    NSAssert(success != nil, @"回调不能为空");
    
    [[QBApiManager sharedApi] requestHeadLineDataWithURL:url success:^(NSDictionary *responseObject) {
        
        NSString *key = responseObject.keyEnumerator.nextObject;
        // 取出数组
        NSArray *data = responseObject[key];
        
        NSMutableArray *dataM = [NSMutableArray array];
        
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [dataM addObject:[QBHeadLineModel headLineWithDict:obj]];
        }];
        
        success(dataM.copy);
        
    } error:^(NSError *errorInfo) {
        
        success(nil);
    }];
    
}
@end
