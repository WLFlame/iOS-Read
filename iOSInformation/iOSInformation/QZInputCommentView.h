//
//  QZInputCommentView.h
//  QQZQ
//
//  Created by ywl on 16/4/19.
//  Copyright © 2016年 cafuc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QZInputCommentView;
@protocol QZInputCommentViewDelegate <NSObject>

- (void)inputCommentViewDidClickPost:(QZInputCommentView *)inputView andContent:(NSString *)content;
- (void)inputCommentViewShouldChangeHeight:(QZInputCommentView *)inputView andHeight:(CGFloat)height;
@end

@interface QZInputCommentView : UIView

@property (nonatomic, weak) id<QZInputCommentViewDelegate> delegate;
- (void)reset;
@end
