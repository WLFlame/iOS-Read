//
//  WLRefreshHeader.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLRefreshHeader.h"

@interface WLRefreshHeader()

@property (nonatomic, strong) CAShapeLayer *pathLayer;
@end

@implementation WLRefreshHeader


- (CAShapeLayer *)pathLayer
{
    if (!_pathLayer) {
        _pathLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 25, 25)];
        _pathLayer.path = path.CGPath;
        _pathLayer.strokeColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0].CGColor;
        _pathLayer.fillColor = [UIColor whiteColor].CGColor;
        _pathLayer.lineWidth = 1.0f;
        _pathLayer.speed = 0;
        _pathLayer.timeOffset = 0;
        [self.layer addSublayer:_pathLayer];
        [_pathLayer removeAllAnimations];
        _pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
        [self addAnimation];
    }
    return _pathLayer;
}

- (void)addAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    _pathLayer.timeOffset = 0;
}

- (void)addRefresingAnimation
{
//    CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation1.duration = 1.0;
//    pathAnimation1.fromValue = @(0.25);
//    pathAnimation1.toValue = @(1);
//    [_pathLayer addAnimation:pathAnimation1 forKey:@"strokeEndRefresing"];
    _pathLayer.speed = 1;
//    pathAnimation1.repeatCount = HUGE;
//    pathAnimation1.removedOnCompletion = NO;
//     pathAnimation1.fillMode = kCAFillModeForwards;
//    
//    CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    pathAnimation2.duration = 1.0;
//    pathAnimation2.fromValue = @(0);
//    pathAnimation2.toValue = @(0.75);
//    [_pathLayer addAnimation:pathAnimation2 forKey:@"strokeStartRefresing"];
//    pathAnimation2.repeatCount = HUGE;
//    pathAnimation2.removedOnCompletion = NO;
//    pathAnimation2.fillMode = kCAFillModeForwards;
    
    self.pathLayer.strokeEnd = 0.25;

    
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation1.repeatCount = INT_MAX;
    animation1.fromValue = @(0);
    animation1.toValue = @(M_PI * 2);
    animation1.duration = 1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
//    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//   
//    animation2.repeatCount = INT_MAX;
//    animation2.fromValue = @(0.25);
//    animation2.toValue = @1;
//    animation2.duration = 1;
//     animation2.fillMode = kCAFillModeForwards;
//    animation2.removedOnCompletion = YES;
//    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//  
    [_pathLayer addAnimation:animation1 forKey:@"StrokeStartAnim"];
//    [_pathLayer addAnimation:animation2 forKey:@"StrokeEndAnim"];
}





- (void)progressDragChangeValue:(CGFloat)vlaue{
    
    self.pathLayer.timeOffset = vlaue;
}

#pragma mark - 实现父类方法
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    NSLog(@"percent %f",pullingPercent);
    if (pullingPercent == 0) {
        [self.pathLayer removeAllAnimations];
        [self addAnimation];
    }
    // 下拉刷新从2开始
    if (pullingPercent > 0.2) {
        [self progressDragChangeValue:(pullingPercent - 0.2) * 8];
    }
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.pathLayer.frame = CGRectMake((self.frame.size.width - self.pathLayer.bounds.size.width) * 0.5, (self.frame.size.height - self.pathLayer.bounds.size.height) * 0.5, self.pathLayer.bounds.size.width, self.pathLayer.bounds.size.height);;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    switch (state) {
        case MJRefreshStateRefreshing:
        {
           // 添加刷新动画
            [self.pathLayer removeAllAnimations];
            [self addRefresingAnimation];
        }
            break;
        case MJRefreshStateIdle:
        {
            [self.pathLayer removeAllAnimations];
            self.pathLayer.timeOffset = 0;
            self.pathLayer.speed = 0;
        }
            break;
        case MJRefreshStateWillRefresh:
        {
            
        }
            break;
        default:
            break;
    }
}


@end





