//
//  WLInterviewModel.m
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLInterviewModel.h"

@implementation WLInterviewModel

+ (NSArray *)loadInterviewModels
{
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"]];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in plistArray) {
        WLInterviewModel *model = [[WLInterviewModel alloc] init];
        model.question = dic[@"question"];
        model.answer = dic[@"answer"];
        [tempArray addObject:model];
    }
    return [tempArray copy];
}

@end
