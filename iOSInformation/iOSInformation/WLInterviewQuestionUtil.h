//
//  WLInterviewQuestionUtil.h
//  iOSInformation
//
//  Created by teed on 2017/1/7.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLInterviewQuestionUtil : NSObject
@property (nonatomic, strong) NSArray *interviews;
+ (instancetype)sharedInstance;
@end
