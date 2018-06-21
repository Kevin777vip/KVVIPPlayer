//
//  BaseWebViewController.m
//  FengbangC
//
//  Created by kevin on 03/01/2018.
//  Copyright © 2018 kevin. All rights reserved.
//

#import "BaseWebViewController.h"
#import "WebViewController.h"
@import WebKit;
@interface BaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) UIButton *topButton;
@property (nonatomic,strong) UITextField *topTextField;
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
    [self configView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setUrlStr:_webUrlStr];
//    [self setUrlStr:@"http://www.iqiyi.com"];
    //http://api.xfsub.com/index.php?url=
}

- (void)configView {
    self.view.backgroundColor = [UIColor whiteColor];

    _topTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width-80, 40)];
    _topTextField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_topTextField];
    
    _topButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-80, 64, 80, 40)];
    _topButton.backgroundColor = [UIColor greenColor];
    [_topButton setTitle:@"vip" forState:UIControlStateNormal];
    [_topButton addTarget:self action:@selector(vipButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topButton];
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64+40, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    NSString *customUserAgent = @"iPhone";
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_webView setCustomUserAgent:customUserAgent];
    [self.view addSubview:_webView];
}

- (void)vipButtonClicked{
    NSString *urlstr = [NSString stringWithFormat:@"http://api.xfsub.com/index.php?url=%@",_topTextField.text];
    WebViewController *webView = [[WebViewController alloc]init];
    webView.webUrlStr = urlstr;
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)configNavigation {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)setUrlStr:(NSString *)urlStr {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
//    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    _topTextField.text = navigationResponse.response.URL.absoluteString;
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//    return [[WKWebView alloc]init];
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}

@end
