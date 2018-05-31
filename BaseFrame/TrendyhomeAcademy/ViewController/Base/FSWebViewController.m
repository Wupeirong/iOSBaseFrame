//
//  FSWebViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/25.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSWebViewController.h"



@interface FSWebViewController ()<WKNavigationDelegate>

@property (nonatomic, assign) double lastProgress;//上次进度条位置

@end

@implementation FSWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
        _progressColor = [UIColor greenColor];//[UIColor colorWithHexString:@"0485d1"];
    }
    return self;
}

- (void)setUrl:(NSString *)url {
    if (_url != url) {
        _url = url;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWebView];
    //适配iOS11
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark -初始化webview
- (void)initWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    configuration.preferences.javaScriptEnabled = YES;//打开js交互
    _webConfiguration = configuration;
    CGRect frame = self.view.bounds;
    self.webView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.allowsBackForwardNavigationGestures = YES;//打开网页间的滑动返回
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    //监控进度
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    
    //进度条
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.tintColor = _progressColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [_webView addSubview:_progressView];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
}

#pragma mark -进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self updateProgress:_webView.estimatedProgress];
}

#pragma mark -更新进度条
- (void)updateProgress:(double)progress {
    self.progressView.alpha = 1;
    if (progress > _lastProgress) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    }else {
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    FSWeakSelf(self)
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.progressView.alpha = 0;
            [weakself.progressView setProgress:0];
            weakself.lastProgress = 0;
        });
    }
}


#pragma mark -navigation delegate
//加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
    [self updateProgress:webView.estimatedProgress];
    [self updateNavigationItems];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    DLog(@"error=%@",error);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    [self updateNavigationItems];
    
    NSURL *url = webView.URL;
   //打开wkwebview禁用了电话和跳转appstore 通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url options:nil completionHandler:nil];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url options:nil completionHandler:nil];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)updateNavigationItems{
    
}


- (void)dealloc {
    
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
