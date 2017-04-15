//
//  WLInterviewSetView.h
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLInterviewSetViewDelegate <NSObject>

- (void)interviewSetViewToSeeAnswer;
- (void)interviewSetViewToHideAnswer;

@end

@interface WLInterviewSetView : UIView

@property (nonatomic,weak) id<WLInterviewSetViewDelegate> delegate;

@end
