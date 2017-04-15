//
//  WLArticleMoreView.m
//  iOSInformation
//
//  Created by teed on 2017/1/5.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLArticleMoreView.h"

@interface WLArticleMoreView()
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation WLArticleMoreView

- (IBAction)sliderValueChanged:(UISlider *)sender {
    if ([self.delegate respondsToSelector:@selector(articleMoreViewSliderValueChanged:andValue:)]) {
        [self.delegate articleMoreViewSliderValueChanged:self andValue:sender.value];
    }
}

- (void)setBrightness:(CGFloat)brightness
{
    self.slider.value = brightness;
}


@end
