//
//  LZYPWebViewVC.m
//  LZYP
//
//  Created by sxy on 2019/10/25.
//  Copyright © 2019 LZYP-iOS-Andrew. All rights reserved.
//

#import "LZYPWebViewVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface LZYPWebViewVC ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) UIButton *backButton;//返回按钮
@property (nonatomic, strong) UIButton *closeButton;//关闭按钮
@property (nonatomic, strong) UIButton *reFreshButton;//刷新按钮
@property (nonatomic, strong) NSString *getGoodsId;//拦截获取到的产品ID

@end

@implementation LZYPWebViewVC

- (instancetype)initWithContent:(NSString *)content contentType:(LZYPWebViewContentType)contentType navBgColor:(UIColor *)navColor titleColor:(UIColor *)titleColor{
    if (self = [super init]) {
        _contentType = contentType;
        _content = content;
        _webTitleColor = titleColor;
        _naviBackGroundColor = navColor;
    }
    
    return self;
}

- (instancetype)initWithURL:(NSString *)url{
    if (self = [super init]) {
        _content = url;
        _contentType = LZYPWebViewURLContentType;
        _webTitleColor = [UIColor grayColor];
        _naviBackGroundColor = WHITE_COLOR;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加webView
    [self.view addSubview:self.webView];
    //加载webView
    if (self.contentType == LZYPWebViewURLContentType) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.content]];
        [self.webView loadRequest:request];
    }
    //导航View
    [self.view addSubview:self.naviView];
    //标题
    self.titleLabel.frame = CGRectMake(100, NavigationBarHeight-44, kScreenWidth-200, 44);
    [self.naviView addSubview:self.titleLabel];
    //webView的进度条
    [self.view addSubview:self.progressView];
    //刷新按钮
    [self.view addSubview:self.reFreshButton];
    // 添加观察者 // 进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    // 标题
    if ([self.webTitle isEqualToString:@""] || self.webTitle == nil) {
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }else{
        self.titleLabel.text = self.webTitle;
    }
    
}

- (WKWebView *)webView {
    if (_webView == nil){
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, kScreenWidth, kScreenHeight-NavigationBarHeight) configuration:config];
        _webView.opaque = NO;
        _webView.UIDelegate =self;
        _webView.navigationDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.backgroundColor = WHITE_COLOR;
    }
    
    return _webView;
}

- (UIView *)naviView {
    if (_naviView == nil){
        _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, NavigationBarHeight)];
        _naviView.backgroundColor = _naviBackGroundColor;
        //返回按钮
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, NavigationBarHeight - 44, 44, 44);
        if (self.naviBackGroundColor == [UIColor whiteColor]) {
            [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        }else{
            [self.backButton setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
        }
        [self.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_naviView addSubview:self.backButton];
        //    //关闭按钮
        //    _closeButton = [UIButton buttonWithTitle:@"关闭" titleColor:(self.naviBackGroundColor == [UIColor whiteColor]) ? [UIColor grayColor] : WHITE_COLOR];
        //    [self.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //    self.closeButton.frame = CGRectMake(50, NavigationBarHeight - 44, 44, 44);
        //    [_naviView addSubview:self.closeButton];
    }
    
    return _naviView;
}

- (UIButton *)reFreshButton {
    if (_reFreshButton == nil){
        //    _reFreshButton = [UIButton buttonWithTitle:@"刷新" titleColor:(self.naviBackGroundColor == [UIColor whiteColor]) ? [UIColor grayColor] : WHITE_COLOR];
        //    [_reFreshButton addTarget:self action:@selector(reFreshButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //    _reFreshButton.frame = CGRectMake(kScreenWidth-50, NavigationBarHeight - 44, 44, 44);
    }
    
    return _reFreshButton;
}

- (UIProgressView *)progressView {
    if (_progressView == nil){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, kScreenWidth, 1)];
        _progressView.progress = 0;
        //    _progressView.progressTintColor = MainNaviColor;
    }
    
    return _progressView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        //    _titleLabel.textColor = TEXT_COLOR_333333;
    }
    
    return _titleLabel;
}

/// 关闭按钮
- (void)closeButtonClick{
    //  if (self.canGoBack) {
    [self.navigationController popViewControllerAnimated:YES];
    //  }else{
    //    [self.webView callHandler:@"execWebViewCloseEvent" arguments:@[]];
    //  }
}


/// 返回按钮
- (void)backButtonClick {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/// 刷新按钮
- (void)reFreshButtonClick{
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate  webView开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

#pragma mark webView加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}

#pragma mark webView加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

//- (void)registerJSMethod{
//  //注册与JS交互的方法
//  [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"JS2NativeProxy"];
//}

/**
 和JS交互的时候一般 已知JS方法名，JS方法有回调回来参数的时候 使用此方法和JS实现交互
 message 参数里面 有方法名和参数 可与前端自定义好结构 实现交互
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.webTitleColor == WHITE_COLOR) {
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    }else {
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    }
    self.navigationController.navigationBar.hidden = YES;
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    if ([self.titleLabel.text isEqualToString:@""] || self.titleLabel.text == nil) {
        [_webView removeObserver:self forKeyPath:@"title"];
    }
    _webView.navigationDelegate = nil;
}

//-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
//{
//  NSLog(@"createWebViewWithConfiguration");
//  if (!navigationAction.targetFrame.isMainFrame) {
//    [webView loadRequest:navigationAction.request];
//  }
//  return nil;
//}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//  
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 转字符
- (NSString *)xh_URLDecodedString:(NSString *)urlString
{
    NSString *string = urlString;
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
- (NSString *)xh_URLEncodedString:(NSString *)urlString
{
    NSString *string = urlString;
    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                     (CFStringRef)string,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                     kCFStringEncodingUTF8));
    return encodedString;
}


@end
