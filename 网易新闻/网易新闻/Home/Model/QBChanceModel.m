//
//  QBChanceModel.m
//  网易新闻
//
//  Created by bing on 16/2/27.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "QBChanceModel.h"
#import <YYModel.h>

@implementation QBChanceModel
+ (NSArray *)chanelDatas {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSString *key = result.keyEnumerator.nextObject;
    
    NSArray *array = result[key];
    
    return [NSArray yy_modelArrayWithClass:self json:array];
}
@end
