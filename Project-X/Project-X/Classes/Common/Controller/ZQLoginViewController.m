//
//  ZQLoginViewController.m
//  Project-X
//
//  Created by 陈擎霄 on 2017/2/10.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "ZQLoginViewController.h"
#import "ZQNetWorkHelper.h"
#import "ZQTabbarController.h"
#import "ZQAccount.h"
#import "ZQAccountTool.h"
@interface ZQLoginViewController ()<UIWebViewDelegate, CAAnimationDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation ZQLoginViewController
-(void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];

    }
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = login_title;
    
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
        // 获取code后
        NSString *urlString = request.URL.absoluteString;
        NSRange range = [urlString rangeOfString:@"code="];
        
        if (range.length) {
            
            NSString *code = [urlString substringFromIndex:(range.location + range.length)];
            
            // 给新浪发送POST请求获取access_token
            
            NSDictionary *paramenters = @{@"client_id":kWBAppKey,
                                   @"client_secret":kWBAppSecret,
                                   @"grant_type":@"authorization_code",
                                   @"code":code,
                                   @"redirect_uri":kRedirectURI};
            [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypePost url:oauthUrl params:paramenters success:^(id responseObject) {
                
                ZQAccount *account = [ZQAccount accountWithDic:responseObject];

                // 2.保存到沙盒
                [[ZQAccountTool shareAccountTool] saveAccount:account];
                
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = @"pageCurl";
                transition.subtype = kCATransitionFromRight;
                transition.delegate = self;
                
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
                
                ZQTabbarController *tabBarVC = [[ZQTabbarController alloc] init];
                [[UIApplication sharedApplication].delegate window].rootViewController = tabBarVC;
                //登录成功 获取用户信息
                [self getUsers];
                NSLog(@"登录成功");
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }else{
            NSLog(@"走了这");
        }

        return YES;
    }
    
- (void)getUsers{
    
    if (Acount) {
        NSDictionary *paramenters = @{@"access_token":Acount.access_token,
                                      @"uid":Acount.uid};
        [[ZQNetWorkHelper sharedNetWorkHelper] invokeWithType:ZQInvokeTypeGet url:getUsers params:paramenters success:^(id responseObject) {
            //
            NSLog(@"responseObject%@",responseObject);
         
            ZQUserMessage *userMessage = [ZQUserMessage mj_objectWithKeyValues:responseObject];
            //存储
            NSData *userMessageData = [NSKeyedArchiver archivedDataWithRootObject:userMessage];
            [[NSUserDefaults standardUserDefaults] setObject:userMessageData forKey:@"theuserMessage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //获取
            //获得保存数据
            NSData *getuserMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"theuserMessage"];
            
            
            //转成模型获取数据
            ZQUserMessage *getuserMessage =   [NSKeyedUnarchiver unarchiveObjectWithData:getuserMessageData];
            UserMessage = getuserMessage;
            NSLog(@"userMessage%@",userMessage.screen_name);
        } failure:^(NSError *error) {
            //
            NSLog(@"失败了");
        }];

    }
    
}
@end
