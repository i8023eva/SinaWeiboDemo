//
//  OAuthViewController.m
//  新浪微博-beat
//
//  Created by lyh on 15/11/27.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "RootController.h"
#import "LaunchController.h"
#import "MBProgressHUD+MJ.h"
#import "AccountInfo.h"
#import "EVAAccountTool.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /**
     *  https://api.weibo.com/oauth2/authorize     请求用户授权Token
     *
     client_id		    string	申请应用时分配的AppKey。
     redirect_uri		string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     *
     
     App Key：247667081
     App Secret：30cc102c3d03eadbf7bbb9882f1454c9
     */
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];

    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=247667081&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /**
     *  返回值字段	字段类型	字段说明
        code        string	用于调用access_token，接口获取授权后的access token。
     
     http://www.example.com/response&code=CODE     >>> CODE
     */
    
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        /**
         *  location是一个以0为开始的index，length是表示对象的长度。
         */
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        //禁止加载回调地址
        return NO;
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    /**
     *  https://api.weibo.com/oauth2/access_token       获取授权过的Access Token
     
     
     必选	类型及范围	说明
     client_id		    string	申请应用时分配的AppKey。
     client_secret		string	申请应用时分配的AppSecret。
     grant_type	 	    string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code                 string	调用authorize获得的code值。
     redirect_uri		string	回调地址，需需与注册应用里的回调地址一致。
     *
     *  @return  {
             "access_token": "ACCESS_TOKEN",
             "expires_in": 1234,
             "remind_in":"798114",
             "uid":"12341234"
        }
     返回值字段	字段类型	字段说明
     access_token       string	用于调用access_token，接口获取授权后的access token。
     expires_in           string	access_token的生命周期，单位是秒数。
     remind_in            string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
     uid                     string	当前授权用户的UID。
     */
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型     acceptableContentTypes
    //"Request failed: unacceptable content-type: text/plain"
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"247667081";
    params[@"client_secret"] = @"30cc102c3d03eadbf7bbb9882f1454c9";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        
        AccountInfo *account = [AccountInfo accountWithDict:responseObject];
        
        [EVAAccountTool saveAccount:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败-%@", error);
    }];

    /**
     *  {
             "access_token" = "2.00Q3WT1E02WLlQ4ec27ca2d00bz254";
             "expires_in" = 157679999;
             "remind_in" = 157679999;
             uid = 3967093948;
     }
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
