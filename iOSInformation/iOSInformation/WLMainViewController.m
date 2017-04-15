//
//  WLMainViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLMainViewController.h"
#import "WLMenuTableViewController.h"
#import "WLCococachinaArticleListController.h"
#import "WLNavigationController.h"
#import "WLBlogViewController.h"
#import "WLInterviewsViewController.h"
#import "WLSimulatorInterviewController.h"
#import "WLCollectViewController.h"
#import "WLSetViewController.h"
@interface WLMainViewController () <WLBaseContentViewControllerDelegate, WLMenuTableViewControllerDelegate>

@property (nonatomic, strong) WLMenuTableViewController *menuVc;

@property (nonatomic, strong) WLCococachinaArticleListController *cocoachinaArticleListVc;
@property (nonatomic, strong) WLNavigationController *cocoachinaNavVc;
@property (nonatomic, strong) WLBlogViewController *blogVc;
@property (nonatomic, strong) WLNavigationController *blogNavVc;
@property (nonatomic, strong) WLInterviewsViewController *interviewVc;
@property (nonatomic, strong) WLNavigationController *interviewNavVc;
@property (nonatomic, strong) WLSimulatorInterviewController *simulatorInterviewVc;
@property (nonatomic, strong) WLNavigationController *simulatorNavVc;
@property (nonatomic, strong) WLCollectViewController *collectVc;
@property (nonatomic, strong) WLNavigationController *collectNavVc;
@property (nonatomic, strong) WLSetViewController *setVc;
@property (nonatomic, strong) WLNavigationController *setNavVc;

@property (nonatomic, strong) WLNavigationController *currentNavViewController;
@property (nonatomic, strong) WLBaseContentViewController *currentContentVc;

// 临时变量
@property (nonatomic, assign) CGFloat menuVcViewWidth;

@end

@implementation WLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.menuVc];
    [self.view addSubview:self.menuVc.view];
    self.menuVc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.8, self.view.bounds.size.height);
    [self addChildViewController:self.cocoachinaNavVc];
    [self.view addSubview:self.cocoachinaNavVc.view];
    self.cocoachinaArticleListVc.view.frame = self.view.bounds;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveClickLeftItemNotification) name:BaseContentViewClickLeftItemNotification object:nil];
    self.currentNavViewController = self.cocoachinaNavVc;
    self.currentContentVc = _cocoachinaArticleListVc;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --- 懒加载
- (WLMenuTableViewController *)menuVc
{
    if (!_menuVc) {
        _menuVc = [[WLMenuTableViewController alloc] init];
        _menuVc.delegate = self;
    }
    return _menuVc;
}

- (WLCococachinaArticleListController *)cocoachinaArticleListVc
{
    if (!_cocoachinaArticleListVc) {
        _cocoachinaArticleListVc = [[WLCococachinaArticleListController alloc] init];
        _cocoachinaArticleListVc.delegate = self;
    }
    return _cocoachinaArticleListVc;
}

- (WLNavigationController *)cocoachinaNavVc
{
    if (!_cocoachinaNavVc) {
        _cocoachinaNavVc = [[WLNavigationController alloc] initWithRootViewController:self.cocoachinaArticleListVc];
    }
    return _cocoachinaNavVc;
}

- (WLBlogViewController *)blogVc
{
    if (!_blogVc) {
        _blogVc = [[WLBlogViewController alloc] init];
        _blogVc.delegate = self;
    }
    return _blogVc;
}

- (WLNavigationController *)blogNavVc
{
    if (!_blogNavVc) {
        _blogNavVc = [[WLNavigationController alloc] initWithRootViewController:self.blogVc];
    }
    return _blogNavVc;
}

- (WLInterviewsViewController *)interviewVc
{
    if (!_interviewVc) {
        _interviewVc = [[WLInterviewsViewController alloc] init];
        _interviewVc.delegate = self;
    }
    return _interviewVc;
}

- (WLNavigationController *)interviewNavVc
{
    if (!_interviewNavVc) {
        _interviewNavVc = [[WLNavigationController alloc] initWithRootViewController:self.interviewVc];
    }
    return _interviewNavVc;
}

- (WLSimulatorInterviewController *)simulatorInterviewVc
{
    if (!_simulatorInterviewVc) {
        _simulatorInterviewVc = [[WLSimulatorInterviewController alloc] init];
    }
    return _simulatorInterviewVc;
}

- (WLNavigationController *)simulatorNavVc
{
    if (!_simulatorNavVc) {
        _simulatorNavVc = [[WLNavigationController alloc] initWithRootViewController:self.simulatorInterviewVc];
    }
    return _simulatorNavVc;
}

- (WLCollectViewController *)collectVc
{
    if (!_collectVc) {
        _collectVc = [[WLCollectViewController alloc] init];
        _collectVc.delegate = self;
    }
    return _collectVc;
}

- (WLNavigationController *)collectNavVc
{
    if (!_collectNavVc) {
        _collectNavVc = [[WLNavigationController alloc] initWithRootViewController:self.collectVc];
    }
    return _collectNavVc;
}

- (WLSetViewController *)setVc
{
    if (!_setVc) {
        _setVc = [[WLSetViewController alloc] init];
        _setVc.delegate = self;
    }
    return _setVc;
}

- (WLNavigationController *)setNavVc
{
    if (!_setNavVc) {
        _setNavVc = [[WLNavigationController alloc] initWithRootViewController:self.setVc];
    }
    return _setNavVc;
}

#pragma mark --- receiveClickLeftItemNotification
- (void)receiveClickLeftItemNotification
{
    __weak typeof(self) weak_self = self;
    if (self.currentNavViewController.view.x == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            weak_self.currentNavViewController.view.x = weak_self.view.width * 0.8;
        }];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            weak_self.currentNavViewController.view.x = 0;
        }];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    
}

#pragma mark --- WLBaseContentViewControllerDelegate
static bool transitionBegin = false;
- (void)baseContentViewControllerPanBegin
{
    self.menuVcViewWidth = self.menuVc.view.width;
    if (self.currentNavViewController.view.x <= 0.01) {
        transitionBegin = true;
    } else {
        transitionBegin = false;
    }
    
}

- (void)baseContentViewControllerTransitionX:(CGFloat)transitionX
{
    if (transitionX > 0) {
        // 往右
        if (self.currentNavViewController.view.x + transitionX >= self.view.bounds.size.width * 0.8 && self.currentNavViewController.view.x + transitionX <= self.view.bounds.size.width * 0.85) {
            if (!transitionBegin) {
                // 不是开始才可以有动作,开始拉伸
                CGFloat scale = (self.currentNavViewController.view.x + transitionX) / self.menuVcViewWidth;
                self.menuVc.view.layer.transform = CATransform3DMakeScale(scale, 1, 1);
                self.currentNavViewController.view.x += transitionX;
                self.menuVc.view.x = 0;
            }
        } else {
            if (self.currentNavViewController.view.x + transitionX <= self.view.bounds.size.width * 0.85) {
                self.currentNavViewController.view.x += transitionX;
            }
            
        }
    } else {
        // 往左
        if (self.currentNavViewController.view.x >= 0.1) {
            if (self.currentNavViewController.view.x + transitionX <= 5) {
                self.currentNavViewController.view.x = 0;
            } else {
                self.currentNavViewController.view.x += transitionX;
            }
        }
    }
    transitionBegin = false;
}

- (void)baseContentViewControllerPanEnd
{
    if (self.currentNavViewController.view.x <= 0.01) {
        self.currentContentVc.panGesture.enabled = NO;
    }
    
    // 回复
    if (self.currentNavViewController.view.x >= self.view.bounds.size.width * 0.79) {
        __weak typeof(self) weak_self = self;
        [UIView animateWithDuration:0.15 animations:^{
            weak_self.currentNavViewController.view.x = weak_self.view.bounds.size.width * 0.8;
            weak_self.menuVc.view.layer.transform = CATransform3DIdentity;
            weak_self.menuVc.view.x = 0;
        }];
    } else if (self.currentNavViewController.view.x >= self.view.bounds.size.width * 0.3) {
        // 中间往右
        __weak typeof(self) weak_self = self;
        [UIView animateWithDuration:0.2 animations:^{
            weak_self.currentNavViewController.view.x = weak_self.view.bounds.size.width * 0.8;
            weak_self.menuVc.view.x = 0;
        }];
    } else {
        // 中间往左
        __weak typeof(self) weak_self = self;
        [UIView animateWithDuration:0.2 animations:^{
            weak_self.currentNavViewController.view.x = 0;
            weak_self.menuVc.view.x = 0;
        }];
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

#pragma mark --- WLMenuTableViewControllerDelegate
- (void)menuTableViewControllerDidSeletedIndex:(NSInteger)index
{
    UIViewController *tempVc;
    switch (index) {
        case 0:
        {
            tempVc = self.collectNavVc;
        }
            break;
        case 1:
        {
        
        }
            break;
        case 2:
        {
            tempVc = self.cocoachinaNavVc;
        }
            break;
        case 3:
        {
            tempVc = self.blogNavVc;
        }
            break;
        case 4:
        {
            tempVc = self.interviewNavVc;
        }
            break;
        case 5:
        {
            tempVc = self.simulatorNavVc;
        }
            break;
        case 6:
        {
            tempVc = self.setNavVc;
        }
            break;
        default:
            break;
    }
    
    if (![tempVc isEqual:self.currentNavViewController] && tempVc != nil) {
        [self.currentNavViewController removeFromParentViewController];
        [self.currentNavViewController.view removeFromSuperview];
        [self addChildViewController:tempVc];
        [self.view addSubview:tempVc.view];
        tempVc.view.frame = self.currentNavViewController.view.frame;
        self.currentNavViewController = (WLNavigationController *)tempVc;
        self.currentContentVc = (WLBaseContentViewController *)((WLNavigationController *)tempVc).topViewController;
        
        __weak typeof(self) weak_self = self;
        [UIView animateWithDuration:0.2 animations:^{
            weak_self.currentNavViewController.view.x = 0;
            weak_self.menuVc.view.x = 0;
        }];
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }
}

@end











