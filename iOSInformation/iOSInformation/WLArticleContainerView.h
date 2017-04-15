//
//  WLArticleContainerView.h
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@class WLCocoaArticleDetailModel;

@protocol WLArticleContainerViewDelegate <NSObject>

- (void)articleContainerViewDidClickImage:(NSString *)imageURL;

@end

@interface WLArticleContainerView : UIView
@property (nonatomic, strong) WLCocoaArticleDetailModel *articleModel;
@property (nonatomic, strong) WKWebView *contentWebView;
- (void)loadArticleDetail:(WLCocoaArticleDetailModel *)model;

@property (nonatomic, weak) id<WLArticleContainerViewDelegate> delegate;

@end
