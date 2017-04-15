//
//  WLCocoachinaArticleBottomView.h
//  iOSInformation
//
//  Created by ywl on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLCocoachinaArticleBottomView;
@protocol WLCocoachinaArticleBottomViewDelegate <NSObject>

- (void)cocoachinaArticleBottomViewBackBtnClick:(WLCocoachinaArticleBottomView *)bottomView;
- (void)cocoachinaArticleBottomViewCommentBtnClick:(WLCocoachinaArticleBottomView *)bottomView;
- (void)cocoachinaArticleBottomViewLikeBtnClick:(WLCocoachinaArticleBottomView *)bottomView;
- (void)cocoachinaArticleBottomViewShareBtnClick:(WLCocoachinaArticleBottomView *)bottomView;
- (void)cocoachinaArticleBottomViewMoreBtnClick:(WLCocoachinaArticleBottomView *)bottomView;

@end

@interface WLCocoachinaArticleBottomView : UIView
+ (instancetype)cocoaArticleBottomView;
@property (nonatomic, weak) id<WLCocoachinaArticleBottomViewDelegate> delegate;
@property (nonatomic, assign) BOOL seletedLike;
@end
