//
//  WLCocoachinaListViewCell.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCocoachinaListViewCell.h"
#import "WLCocoaModel.h"
#import "UIImageView+WebCache.h"
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>
@interface WLCocoachinaListViewCell()
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation WLCocoachinaListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(WLCocoaModel *)model
{
    _model = model;
    __weak typeof(self) weak_self = self;
    if ([model.imgUrl containsString:@".gif"]) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.imgUrl] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            FLAnimatedImage *flImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
            weak_self.image.animatedImage = flImage;
            
        }];
    } else {
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weak_self.image.image = image;
            if (cacheType == SDImageCacheTypeNone) {
                weak_self.image.alpha = 0;
                [UIView animateWithDuration:0.25 animations:^{
                    weak_self.image.alpha = 1;
                }];
                
            }
        }];
    }
   
    self.title.text = model.title;
    self.time.text = model.postTime;
}

@end
