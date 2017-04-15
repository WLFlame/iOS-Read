//
//  WLWebViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLWebViewController.h"
#import <WebKit/WebKit.h>
#import "NSObject+FBKVOController.h"
#import "WLBlogModel.h"
@interface WLWebViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.name;
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progressTintColor = [UIColor greenColor];
    self.progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 2);
    
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height - 64 ) configuration:configuration];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]]];
    self.webView.navigationDelegate = self;
    [self addObserver];
}


- (void)addObserver
{
    __weak typeof(self) weak_self = self;
    [self.KVOController observe:self.webView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        [weak_self.progressView setProgress:[change[@"new"] floatValue] animated:YES];
        if ([change[@"new"] floatValue] > 0.9) {
            
            [weak_self.progressView setProgress:1.0 animated:YES];
            weak_self.progressView.hidden = YES;
            [weak_self.progressView setProgress:0];
        } else {
            weak_self.progressView.hidden = NO;
        }
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.progressView setProgress:1];
}


@end
