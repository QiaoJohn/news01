//
//  QBHTTPManager.h
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface QBHTTPManager : AFHTTPSessionManager
+ (instancetype)sharedManager;
@end
