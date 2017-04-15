//
//  WLAnswerContainerView.h
//  iOSInformation
//
//  Created by teed on 2017/1/7.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLInterviewModel;
@interface WLAnswerContainerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;
@property (nonatomic, strong) WLInterviewModel *model;
@property (nonatomic, copy) void(^operatorClickHide)();
@end
