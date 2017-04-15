//
//  WLBaseContentViewController.h
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const BaseContentViewClickLeftItemNotification;

@protocol WLBaseContentViewControllerDelegate <NSObject>

- (void)baseContentViewControllerTransitionX:(CGFloat)transitionX;
- (void)baseContentViewControllerPanBegin;
- (void)baseContentViewControllerPanEnd;

@end

@interface WLBaseContentViewController : UIViewController

@property (nonatomic, weak) id<WLBaseContentViewControllerDelegate> delegate;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@end
