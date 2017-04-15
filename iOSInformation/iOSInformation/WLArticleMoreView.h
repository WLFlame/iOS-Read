//
//  WLArticleMoreView.h
//  iOSInformation
//
//  Created by teed on 2017/1/5.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLArticleMoreView;
@protocol WLArticleMoreViewDelegate <NSObject>

- (void)articleMoreViewSliderValueChanged:(WLArticleMoreView *)moreView andValue:(CGFloat)value;

@end

@interface WLArticleMoreView : UIView
@property (nonatomic, weak) id<WLArticleMoreViewDelegate> delegate;
- (void)setBrightness:(CGFloat)brightness;
@end
