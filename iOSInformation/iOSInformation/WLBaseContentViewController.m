//
//  WLBaseContentViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLBaseContentViewController.h"

NSString *const BaseContentViewClickLeftItemNotification = @"BaseContentViewClickLeftItemNotification";

@interface WLBaseContentViewController ()


@property (nonatomic, assign) CGPoint lastTransition;
@end

@implementation WLBaseContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI
{
    UIButton *menuButton = [[UIButton alloc] init];
    [menuButton addTarget:self action:@selector(btnClickLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setImage:[UIImage imageNamed:@"icon_menu_blue_23x23_"] forState:UIControlStateNormal];
    [menuButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];
    self.panGesture = panGesture;
    self.panGesture.enabled = NO;
    
}

- (void)btnClickLeftItem
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BaseContentViewClickLeftItemNotification object:nil];
    self.panGesture.enabled = YES;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.lastTransition = CGPointZero;
        if ([self.delegate respondsToSelector:@selector(baseContentViewControllerPanBegin)]) {
            [self.delegate baseContentViewControllerPanBegin];
        }
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint transition = [gesture translationInView:self.view];
        
        if ([self.delegate respondsToSelector:@selector(baseContentViewControllerTransitionX:)]) {
            [self.delegate baseContentViewControllerTransitionX:transition.x - self.lastTransition.x];
        }
        self.lastTransition = transition;
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(baseContentViewControllerPanEnd)]) {
            [self.delegate baseContentViewControllerPanEnd];
        }
        
    }
}

@end









