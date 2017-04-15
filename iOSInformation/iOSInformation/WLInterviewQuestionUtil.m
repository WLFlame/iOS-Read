//
//  WLInterviewQuestionUtil.m
//  iOSInformation
//
//  Created by teed on 2017/1/7.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLInterviewQuestionUtil.h"
#import "WLInterviewModel.h"
@implementation WLInterviewQuestionUtil

static WLInterviewQuestionUtil *_util;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _util = [[WLInterviewQuestionUtil alloc] init];
        _util.interviews = [WLInterviewModel loadInterviewModels];
    });
    return _util;
}

@end
