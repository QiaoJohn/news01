//
//  QBNewsModel.m
//  09News
//
//  Created by bing on 16/2/26.
//  Copyright © 2016年 gzxzmac. All rights reserved.
//

#import "QBNewsModel.h"
#import "QBApiManager.h"
#import <YYModel.h>
#import "QBNewsImageModel.h"

@implementation QBNewsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
   
    return @{@"imgextra" : [QBNewsImageModel class],
             };
}

- (void)setDocid:(NSString *)docid {
    
    _docid = docid.copy;
    
    self.fullURL = [NSString stringWithFormat:@"article/%@/full.html",docid];
}

+ (void)newsDataWithURL:(NSString *)url success:(void (^)(NSArray *))success {
    
    NSAssert(success != nil, @"回调不能为空");
    
    [[QBApiManager sharedApi] requestNewsDataWithURL:url success:^(NSDictionary * responseObject) {
        // 取出第一个key T1348647853363
       // NSLog(@"%@",responseObject);
        NSString *key = responseObject.keyEnumerator.nextObject;
        //        NSLog(@"key == %@",key);
        NSArray *data = responseObject[key];
        
        NSArray *tmp = [NSArray yy_modelArrayWithClass:self json:data];
        
        success(tmp);
        
    } error:^(NSError *errorInfo) {
        
        success(nil);
        
    }];

}
@end
