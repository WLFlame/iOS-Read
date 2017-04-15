//
//  WLInterviewSetView.m
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLInterviewSetView.h"

@implementation WLInterviewSetView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

- (IBAction)tapSeeAnswer{
    if ([self.delegate respondsToSelector:@selector(interviewSetViewToSeeAnswer)]) {
        [self.delegate interviewSetViewToSeeAnswer];
    }
}

- (IBAction)tapToHideAnswer{
    if ([self.delegate respondsToSelector:@selector(interviewSetViewToHideAnswer)]) {
        [self.delegate interviewSetViewToHideAnswer];
    }
}

@end
