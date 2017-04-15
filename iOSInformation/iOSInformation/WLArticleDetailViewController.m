//
//  WLArticleDetailViewController.m
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLArticleDetailViewController.h"
#import "WLRefreshHeader.h"
#import "WLCocoaModel.h"
#import "WLArticleContainerView.h"
#import <IDMPhotoBrowser.h>
#import "WLArticleHeaderView.h"
#import "NSObject+FBKVOController.h"
#import "WLCocoachinaArticleBottomView.h"
#import "DGActivityIndicatorView.h"
#import "WLCocoaCommentViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "WLArticleShareView.h"
#import "WLArticleMoreView.h"
#import <Realm.h>
#import "UMSocialCore/UMSocialCore.h"

@interface WLArticleDetailViewController () <WLArticleContainerViewDelegate, WLCocoachinaArticleBottomViewDelegate, WLArticleMoreViewDelegate>

@property (nonatomic, strong) WLCocoaArticleDetailModel *articleDetail;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) WLArticleContainerView *containerView;
@property (nonatomic, strong) WLArticleHeaderView *articleHeaderView;
@property (nonatomic, assign) CGFloat lastTransitionY;
@property (nonatomic, strong) WLCocoachinaArticleBottomView *articleBottomView;
@property (nonatomic, strong) DGActivityIndicatorView *indicatorView;
@property (nonatomic, strong) WLArticleShareView *shareView;
@property (nonatomic, strong) WLArticleMoreView *articleMoreView;
@property (nonatomic, strong) UIView *dimView;
@end

@implementation WLArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.contentTable];
//    __weak typeof(self) weak_self = self;
//    self.contentTable.mj_header = [WLRefreshHeader headerWithRefreshingBlock:^{
//        [weak_self fetchArticle];
//    }];
    self.fd_prefersNavigationBarHidden = YES;
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.containerView = [[WLArticleContainerView alloc] init];
    self.containerView.frame = self.view.bounds;
    self.containerView.delegate = self;
    [self.view addSubview:self.containerView];
    self.containerView.alpha = 0;
    
    self.articleHeaderView = [[NSBundle mainBundle] loadNibNamed:@"WLArticleHeaderView" owner:nil options:nil].lastObject;
    self.articleHeaderView.frame = CGRectMake(0, 20, self.view.width, 90);
    [self.view addSubview:self.articleHeaderView];
    self.articleHeaderView.cocoa = self.cocoa;
   
    self.lastTransitionY = 0;
    
    UIView *statusBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    statusBarBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusBarBgView];
    [self.view addSubview:self.articleBottomView];
    [self fetchArticle];
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeLineScalePulseOut tintColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] size:20.0f];
    activityIndicatorView.frame = CGRectMake(0, 0, 100.0f, 100.0f);
    activityIndicatorView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    self.indicatorView = activityIndicatorView;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __weak typeof(self) weak_self = self;
    [self.KVOController observe:self.containerView.contentWebView.scrollView keyPath:@"contentOffset" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        CGPoint pointNew = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat transitionY = pointNew.y - weak_self.lastTransitionY;
        NSLog(@"transitionY %f", pointNew.y);
        // 初始 -115 临界值 -5
        if (transitionY >= 0) {
            // 往上
            if (CGRectGetMaxY(weak_self.articleHeaderView.frame) > -CGRectGetMaxY(weak_self.articleHeaderView.frame)) {
                if (transitionY > 0.1 && transitionY < 89.9) {
                    weak_self.articleHeaderView.y -= transitionY;
                }
            }
        } else {
            // 往下
            if (pointNew.y >= -114.9 && pointNew.y <= -4.9) {
                if (transitionY < 0) {
                    weak_self.articleHeaderView.y -= transitionY;
                }
                
            }
            if (pointNew.y <= -114.9 && pointNew.y >= -115 ) {
                weak_self.articleHeaderView.y = 20;
            }
        }
        
        weak_self.lastTransitionY = pointNew.y;
       
        
    }];
}


- (void)fetchArticle
{
    __weak typeof(self) weak_self = self;
    [WLCocoaArticleDetailModel loadWithArticleURL:self.cocoa.articleUrl complete:^(WLCocoaArticleDetailModel *model, NSError *error) {
        if (error) {
            [weak_self.view addSubview:weak_self.errorLabel];
        } else {
            [weak_self.errorLabel removeFromSuperview];
            weak_self.articleDetail = model;
            [weak_self.containerView loadArticleDetail:model];
            [UIView animateWithDuration:0.25 animations:^{
                [weak_self.indicatorView removeFromSuperview];
                weak_self.containerView.alpha = 1;
                
            }];
        }
    }];
}

- (void)showToPlatform:(NSInteger)platform
{
    NSString *shareTitle = self.cocoa.title;
    NSString *sharelink = self.cocoa.articleUrl;
    NSString *shareText = @"点击查看";
      UIImage *shareImage =  [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:self.cocoa.imgUrl];
  
    
    
    
    
    UMShareWebpageObject *webPageObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareText thumImage:shareImage];
    
    webPageObject.webpageUrl = sharelink;
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObjectWithMediaObject:webPageObject];
    
    UMSocialPlatformType sharePlatformType = UMSocialPlatformType_QQ;
    
    
    switch (platform) {
        case 0:
        {
            sharePlatformType = UMSocialPlatformType_QQ;
        }
            break;
        case 1:
        {
            sharePlatformType = UMSocialPlatformType_Qzone;
        }
            break;
        case 2:
        {
            sharePlatformType = UMSocialPlatformType_WechatSession;
        }
            break;
        default:
        {
            sharePlatformType = UMSocialPlatformType_WechatTimeLine;
        }
            break;
    }
    __weak typeof(self) weak_self = self;
    [[UMSocialManager defaultManager] shareToPlatform:sharePlatformType messageObject:messageObject currentViewController:weak_self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];

}

#pragma mark --- 懒加载

- (UILabel *)errorLabel
{
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.text = @"出现错误，请稍后再试";
        _errorLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [_errorLabel sizeToFit];
        _errorLabel.font = [UIFont systemFontOfSize:15];
        _errorLabel.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5 - 50);
        _errorLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _errorLabel;
}

- (WLCocoachinaArticleBottomView *)articleBottomView
{
    if (!_articleBottomView) {
        _articleBottomView = [WLCocoachinaArticleBottomView cocoaArticleBottomView];
        _articleBottomView.frame = CGRectMake(0, self.view.height - 44, self.view.width, 44);
        _articleBottomView.delegate = self;
        _articleBottomView.seletedLike = self.seletedLike;
    }
    return _articleBottomView;
}

- (WLArticleShareView *)shareView
{
    if (!_shareView) {
        _shareView = [[NSBundle mainBundle] loadNibNamed:@"WLArticleShareView" owner:nil options:nil].lastObject;
        _shareView.frame = CGRectMake(0, self.view.height - 64, self.view.width, 100);
        __weak typeof(self) weak_self = self;
        [_shareView setOperatorShareTo:^(NSInteger platform) {
            [weak_self showToPlatform:platform];
        }];
    }
    return _shareView;
}

- (UIView *)dimView
{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:self.view.bounds];
        _dimView.backgroundColor = [UIColor blackColor];
        _dimView.alpha = 0;
        UITapGestureRecognizer *dimGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimTapGes)];
        _dimView.userInteractionEnabled = YES;
        [_dimView addGestureRecognizer:dimGes];
    }
    return _dimView;
}

- (WLArticleMoreView *)articleMoreView
{
    if (!_articleMoreView) {
        _articleMoreView = [[NSBundle mainBundle] loadNibNamed:@"WLArticleMoreView" owner:nil options:nil].lastObject;
        _articleMoreView.frame = CGRectMake(0, self.view.height -64, self.view.width, 70);
        _articleMoreView.delegate = self;
    }
    return _articleMoreView;
}

#pragma mark --- Action
- (void)dimTapGes
{
    UIView *temp;
    if (self.shareView.superview) {
        temp = self.shareView;
    } else if (self.articleMoreView.superview) {
        temp = self.articleMoreView;
    }
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:0.25 animations:^{
        temp.y = weak_self.view.height;
        weak_self.dimView.alpha = 0;
    } completion:^(BOOL finished) {
        [temp removeFromSuperview];
        [weak_self.dimView removeFromSuperview];
    }];
}

#pragma mark --- WLArticleContainerViewDelegate
- (void)articleContainerViewDidClickImage:(NSString *)imageURL
{
    if (![imageURL containsString:@".gif"]) {
        IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:imageURL]];
        IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:@[photo]];
        [self presentViewController:browser animated:YES completion:nil];
    }
    
}

#pragma mark --- WLCocoachinaArticleBottomViewDelegate
- (void)cocoachinaArticleBottomViewBackBtnClick:(WLCocoachinaArticleBottomView *)bottomView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cocoachinaArticleBottomViewCommentBtnClick:(WLCocoachinaArticleBottomView *)bottomView
{
    WLCocoaCommentViewController *commentVc = [[WLCocoaCommentViewController alloc] init];
    [self.navigationController pushViewController:commentVc animated:YES];
}

- (void)cocoachinaArticleBottomViewLikeBtnClick:(WLCocoachinaArticleBottomView *)bottomView
{
    // 加入缓存
    RLMRealm *realm = [RLMRealm defaultRealm];
    self.cocoa.createAt = [NSDate date];
    [realm beginWriteTransaction];
    [realm addObject:self.cocoa];
    [realm commitWriteTransaction];
}

- (void)cocoachinaArticleBottomViewShareBtnClick:(WLCocoachinaArticleBottomView *)bottomView
{
    [self.view addSubview:self.dimView];
    [self.view addSubview:self.shareView];
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:0.25 animations:^{
        weak_self.shareView.y = weak_self.view.height - weak_self.shareView.height;
        weak_self.dimView.alpha = 0.2;
    }];
    
}

- (void)cocoachinaArticleBottomViewMoreBtnClick:(WLCocoachinaArticleBottomView *)bottomView
{
    [self.view addSubview:self.dimView];
    [self.view addSubview:self.articleMoreView];
    [self.articleMoreView setBrightness:[[UIScreen mainScreen] brightness]];
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:0.25 animations:^{
        weak_self.articleMoreView.y = weak_self.view.height - weak_self.articleMoreView.height;
        weak_self.dimView.alpha = 0.2;
    }];
}

#pragma mark --- WLArticleMoreViewDelegate
- (void)articleMoreViewSliderValueChanged:(WLArticleMoreView *)moreView andValue:(CGFloat)value
{
    [[UIScreen mainScreen] setBrightness:value];
}


@end


















