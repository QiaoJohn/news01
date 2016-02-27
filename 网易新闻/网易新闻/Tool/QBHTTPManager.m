//
//  QBHTTPManager.m
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBHTTPManager.h"
#define QBBaseURL [NSURL URLWithString:@"http://c.m.163.com/nc/"]
@implementation QBHTTPManager
+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    static QBHTTPManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithBaseURL:QBBaseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    });
    return instance;
}
@end
