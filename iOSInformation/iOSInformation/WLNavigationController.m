//
//  WLNavigationController.m
//  PanSoSo
//
//  Created by ywl on 2016/12/30.
//  Copyright © 2016年 ywl. All rights reserved.
//

#import "WLNavigationController.h"
@interface WLNavigationController ()
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation WLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationBarAppearance];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)navigationBarAppearance
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //  nc.navigationBar.translucent = NO;
    //去掉导航条的半透明
    //    bar.barTintColor = RGBACOLOR(45, 45, 45, 1);
    bar.barTintColor = [UIColor whiteColor];
    bar.translucent = NO;
    bar.shadowImage = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont fontWithName:@".SFUIDisplay-Thin" size:18];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [bar setTitleTextAttributes:dict];
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //    UIImage *backImage = [UIImage imageNamed:@"back"];
    //    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width - 1, 0, 1)];
    //    [item setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"ic_recommend_toolbar_back_24x24_"] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(0, 0, 40, 60);
        _backBtn.titleLabel.hidden = YES;
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //        CGFloat btnW = SCREEN_WIDTH > 375.0 ? 50 : 44;
        //        _backBtn.frame = CGRectMake(0, 0, btnW, 40);
        [_backBtn sizeToFit];
    }
    return _backBtn;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.hidesBackButton = YES;
    if (self.childViewControllers.count > 0) {
        [UINavigationBar appearance].backItem.hidesBackButton = NO;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    }
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
    
}


- (void)backBtnClick
{
   
        [self popViewControllerAnimated:YES];
    
}


@end
