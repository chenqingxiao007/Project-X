//
//  ZQLoginViewController.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/10.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQLoginViewController.h"
#import "WeiboSDK.h"
@interface ZQLoginViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation ZQLoginViewController
-(void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];

    }
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新浪账号授权";
    
    // 添加webView
    [self setupWebView];
    
    
}
- (void)setupWebView{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    // 发送授权请求
    [self OAuth2];

}
- (void)OAuth2{
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",kWBAppKey,kRedirectURI];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
    NSLog(@"--%@", request.URL);

}
#pragma mark - UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
    {

        NSLog(@"RequestURL: %@", request.URL);
        
        // 获取code后
        NSString *urlString = request.URL.absoluteString;
        NSRange range = [urlString rangeOfString:@"code="];
        
        if (range.length) {
            [self.webView removeFromSuperview];
            
            NSString *code = [urlString substringFromIndex:(range.location + range.length)];
            
            // 给新浪发送POST请求获取access_token
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            NSMutableDictionary *paramenters = [NSMutableDictionary dictionary];
            paramenters[@"client_id"] = kWBAppKey;
            paramenters[@"client_secret"] = kWBAppSecret;
            paramenters[@"grant_type"] = @"authorization_code";
            paramenters[@"code"] = code;
            paramenters[@"redirect_uri"] = kRedirectURI;
            NSString *postUrl = @"https://api.weibo.com/oauth2/access_token";
            [manager POST:postUrl parameters:paramenters.mutableCopy progress:^(NSProgress * _Nonnull uploadProgress) {
                //
                NSLog(@"*****");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //
                NSLog(@"授权成功");
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //
                NSLog(@"授权失败");
            }];
        }else{
            NSLog(@"走了这");
        }
        return YES;
    }
    

@end
