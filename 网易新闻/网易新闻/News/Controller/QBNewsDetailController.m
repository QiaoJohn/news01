
//
//  QBNewsDetailController.m
//  网易新闻
//
//  Created by bing on 16/2/29.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "QBNewsDetailController.h"
#import "QBHTTPManager.h"

@interface QBNewsDetailController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *body;// 新闻内容
@property (nonatomic, copy) NSString *newsTitle;// 新闻标题
@property (nonatomic, copy) NSString *time;// 新闻时间
@end

@implementation QBNewsDetailController

- (void)loadView {
    
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
}

- (void)loadData {
    
    [[QBHTTPManager sharedManager] GET:self.newsURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        
        NSString *key = responseObject.keyEnumerator.nextObject;
        // 取出数据
        NSDictionary *result = responseObject[key];
        // 取出body内容
        __block NSString *body = result[@"body"];
        // 取出所有的图片
        NSArray *images = result[@"img"];
        // 循环替换图片数据
        [images enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *ref = obj[@"ref"];
            // 替换字符串
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHTMLWithDict:obj]];
        }];
        
        self.body = body;
        self.newsTitle = result[@"title"];
        self.time = [NSString stringWithFormat:@"%@%@",result[@"ptime"],result[@"source"]];
        // 本地文件html的路径
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"detail.html" withExtension:nil];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"出错");
    }];
}

- (NSString *)imageHTMLWithDict:(NSDictionary *)dict {
    
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"  alt=\"%@\"/>",dict[@"src"],dict[@"alt"]];
    
    return html;
}

- (NSString *)videoHTMLWithDict:(NSDictionary *)dict {
    NSString *html = [NSString stringWithFormat:@"<video width=\"100%%\" controls>"
                      "<source src=\"%@\""
                      " type=\"video/mp4\">"
                      "您的浏览器不支持 HTML5 video 标签。"
                      "</video><span style=\"font-size: 13px;color: dimgrey\">%@</span>",dict[@"url_mp4"],dict[@"alt"]];
    return html;
}

#pragma mark - webView的代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *code = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.time,self.body];
    
    [webView stringByEvaluatingJavaScriptFromString:code];
}
@end
