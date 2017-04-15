//
//  WLArticleContainerView.m
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLArticleContainerView.h"
#import <Masonry.h>
#import "NSObject+FBKVOController.h"
#import "WLCocoaModel.h"
#import "WLStyle.h"





@interface WLArticleContainerView() <WKScriptMessageHandler>



@end

@implementation WLArticleContainerView


- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
    configuretion.preferences = [[WKPreferences alloc] init];
    configuretion.preferences.minimumFontSize = 10;
    configuretion.preferences.javaScriptEnabled = YES;
    configuretion.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    configuretion.userContentController = [[WKUserContentController alloc] init];
    [configuretion.userContentController addScriptMessageHandler:self name:@"clickImage"];
    self.contentWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuretion];
    self.contentWebView.scrollView.contentInset = UIEdgeInsetsMake(95, 0, 44, 0);
    self.contentWebView.scrollView.bounces = NO;
    _contentWebView.opaque = NO;
    _contentWebView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentWebView];
    _contentWebView.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weak_self = self;
    [_contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_self);
        make.bottom.equalTo(weak_self);
        make.left.equalTo(weak_self);
        make.right.equalTo(weak_self);
    }];
    
}

- (void)loadArticleDetail:(WLCocoaArticleDetailModel *)model
{
    if (!model) {
        return;
    }
    _articleModel = model;
    
    if (model.content) {
        NSString *blockCode = @"";
//        <meta name="viewport" content="user-scalable=no,width=device-width,initial-scale=1">
        NSString *style = [NSString stringWithFormat:@"<style>%@%@</style></head><body>",[WLStyle sharedInstance].current_css, blockCode];
        NSString *header1 = @"<meta charset='utf-8'>";
        NSString *header2 = @"<meta name='viewport' content='width=device-width, initial-scale=1.0,minimum-scale=1, maximum-scale=1, user-scalable=no'>";
        NSString *header3 = @"<meta name='MobileOptimized' content='width=device-width'>";
        NSString *header4 = @"<meta name='apple-mobile-web-app-capable' content='yes'>";
        NSString *header5 = @"<meta name='format-detection' content='telephone=no'>";
//        NSString *jquery = [NSString stringWithFormat:@"<script type='text/javascript'>%@</script>", [WLStyle sharedInstance].jquery];
        // 图片响应方法
        NSString *header6 = @"<script type='text/javascript'>function clickImage(src) {window.webkit.messageHandlers.clickImage.postMessage(src);}</script>";
        NSString *header = [NSString stringWithFormat:@"<html><title></title><head>%@%@%@%@%@%@",header1,header2,header3,header4,header5,header6];
        
        NSString *content = [NSString stringWithFormat:@"%@%@%@</body></html>",header,style,model.content];
        [self.contentWebView loadHTMLString:content baseURL:[NSURL URLWithString:@"http://"]];
        
    }
    
    
}

#pragma mark --- WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"clickImage"]) {
        if ([self.delegate respondsToSelector:@selector(articleContainerViewDidClickImage:)]) {
            [self.delegate articleContainerViewDidClickImage:message.body];
        }
        
    }
}



@end














