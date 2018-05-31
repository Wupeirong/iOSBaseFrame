//
//  FSWebViewController.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/25.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewController.h"
#import <WebKit/WebKit.h>

@interface FSWebViewController : FSBaseViewController

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, weak) WKWebViewConfiguration *webConfiguration;

@property (nonatomic, copy) NSString *url;

- (instancetype)initWithUrl:(NSString *)url;

@end
