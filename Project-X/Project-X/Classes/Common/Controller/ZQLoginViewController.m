//
//  ZQLoginViewController.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/10.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQLoginViewController.h"
#import "WeiboSDK.h"
#import "ZQNetWorkHelper.h"
#import "ZQTabbarController.h"
#import "ZQAccount.h"
#import "ZQAccountTool.h"
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
            
            NSMutableDictionary *paramenters = [NSMutableDictionary dictionary];
            paramenters[@"client_id"] = kWBAppKey;
            paramenters[@"client_secret"] = kWBAppSecret;
            paramenters[@"grant_type"] = @"authorization_code";
            paramenters[@"code"] = code;
            paramenters[@"redirect_uri"] = kRedirectURI;
            NSString *postUrl = @"https://api.weibo.com/oauth2/access_token";
            
            [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypePost url:postUrl params:paramenters success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                ZQAccount *account = [ZQAccount accountWithDic:responseObject];
                NSLog(@"account : %@",account);
                NSLog(@"access_token : %@",account.access_token);

                // 2.保存到沙盒
                [[ZQAccountTool shareAccountTool] saveAccount:account];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                        self.view.window.rootViewController = [[ZQTabbarController alloc]init];
                });
                NSLog(@"登录成功");
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
            
        }else{
            NSLog(@"走了这");
        }
        return YES;
    }
    

@end
