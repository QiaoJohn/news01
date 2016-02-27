//
//  QBApiManager.m
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBApiManager.h"
#import "QBHTTPManager.h"

@implementation QBApiManager
+ (instancetype)sharedApi {
    
    static dispatch_once_t onceToken;
    static QBApiManager *instance;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestHeadLineDataWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error {
    
    [[QBHTTPManager sharedManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        
        if (error) {
            
            error(errorInfo);
        }
    }];
}

- (void)requestNewsDataWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error {
    
    [[QBHTTPManager sharedManager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        
        if (error) {
            error(errorInfo);
        }
    }];
}
@end
