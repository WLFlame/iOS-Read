//
//  WLArticleDetailWebViewCell.m
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLArticleDetailWebViewCell.h"
#import <Masonry.h>
#import "NSObject+FBKVOController.h"
#import "WLCocoaModel.h"
#import "WLStyle.h"
#import <WebKit/WebKit.h>

NSString *const HTMLHEADER = @"<html><head><title></title><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0'><meta name='format-detection' content='telephone=no'><meta name='format-detection' content='email=no'/>";

@interface WLArticleDetailWebViewCell()

@property (nonatomic, strong) WKWebView *contentWebView;

@end

@implementation WLArticleDetailWebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.contentWebView = [[WKWebView alloc] init];
//    _contentWebView.userInteractionEnabled = NO;
    _contentWebView.opaque = NO;
    _contentWebView.backgroundColor = [UIColor clearColor];
    _contentWebView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:_contentWebView];
    _contentWebView.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weak_self = self;
    [_contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_self.contentView);
        make.bottom.equalTo(weak_self.contentView);
        make.left.equalTo(weak_self.contentView).offset(10);
        make.right.equalTo(weak_self.contentView).offset(-10);
    }];
    
    [self.KVOController observe:_contentWebView.scrollView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        CGSize size = [change[NSKeyValueChangeNewKey] CGSizeValue];
        weak_self.contentHeight = size.height;
        weak_self.contentHeightChanged(weak_self.contentHeight);
    }];
}

- (void)loadArticleDetail:(WLCocoaArticleDetailModel *)model
{
    if (!model) {
        return;
    }
    _articleModel = model;
    
    if (model.content) {
        NSString *blockCode = @".pl .blockcode { padding: 10px 0 5px 10px;border: 1px solid #CCC;background: #F7F7F7 url(../../static/image/common/codebg.gif) repeat-y 0 0;overflow: hidden;}";
        NSString *style = [NSString stringWithFormat:@"<style>%@%@</style></head><body>",[WLStyle sharedInstance].current_css, blockCode];
        NSString *content = [NSString stringWithFormat:@"%@%@%@</body></html>",HTMLHEADER,style,model.content];
        [self.contentWebView loadHTMLString:content baseURL:[NSURL URLWithString:@"http://"]];
        
    }
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

@end
