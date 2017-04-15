//
//  WLArticleHeaderView.m
//  iOSInformation
//
//  Created by teed on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLArticleHeaderView.h"
#import <UIImageView+WebCache.h>
#import "WLCocoaModel.h"
#import "UIImageView+WebCache.h"
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>
@interface WLArticleHeaderView()
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WLArticleHeaderView

- (void)setCocoa:(WLCocoaModel *)cocoa
{
    _cocoa = cocoa;
    
    __weak typeof(self) weak_self = self;
    if ([cocoa.imgUrl containsString:@".gif"]) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:cocoa.imgUrl] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            FLAnimatedImage *flImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
            weak_self.bgImageView.animatedImage = flImage;
            
        }];
    } else {
        
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:cocoa.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weak_self.bgImageView.image = image;
            if (cacheType == SDImageCacheTypeNone) {
                weak_self.bgImageView.alpha = 0;
                [UIView animateWithDuration:0.25 animations:^{
                    weak_self.bgImageView.alpha = 1;
                }];
                
            }
        }];
    }


    self.titleLabel.text = cocoa.title;
}

@end
