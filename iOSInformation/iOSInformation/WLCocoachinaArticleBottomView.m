//
//  WLCocoachinaArticleBottomView.m
//  iOSInformation
//
//  Created by ywl on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCocoachinaArticleBottomView.h"

@interface WLCocoachinaArticleBottomView()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end

@implementation WLCocoachinaArticleBottomView

+ (instancetype)cocoaArticleBottomView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WLCocoachinaArticleBottomView" owner:nil options:nil].lastObject;
}

- (void)setSeletedLike:(BOOL)seletedLike
{
    _seletedLike = seletedLike;
    if (seletedLike) {
         [self.likeBtn setImage:[UIImage imageNamed:@"ic_recommend_toolbar_favorite_highlight_24x24_"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)backBtnClick {
    if ([self.delegate respondsToSelector:@selector(cocoachinaArticleBottomViewBackBtnClick:)]) {
        [self.delegate cocoachinaArticleBottomViewBackBtnClick:self];
    }
}

- (IBAction)commentBtnClick {
    if ([self.delegate respondsToSelector:@selector(cocoachinaArticleBottomViewCommentBtnClick:)]) {
        [self.delegate cocoachinaArticleBottomViewCommentBtnClick:self];
    }
}

- (IBAction)likeBtnClick {
    if (self.seletedLike) {
        return;
    }
    [self.likeBtn setImage:[UIImage imageNamed:@"ic_recommend_toolbar_favorite_highlight_24x24_"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cocoachinaArticleBottomViewLikeBtnClick:)]) {
        [self.delegate cocoachinaArticleBottomViewLikeBtnClick:self];
    }
}

- (IBAction)shareBtnClick {
    if ([self.delegate respondsToSelector:@selector(cocoachinaArticleBottomViewShareBtnClick:)]) {
        [self.delegate cocoachinaArticleBottomViewShareBtnClick:self];
    }
}

- (IBAction)moreBtnClick {
    if ([self.delegate respondsToSelector:@selector(cocoachinaArticleBottomViewMoreBtnClick:)]) {
        [self.delegate cocoachinaArticleBottomViewMoreBtnClick:self];
    }
}

@end
