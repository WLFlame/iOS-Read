//
//  WLInterviewModel.h
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLInterviewModel : NSObject

@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;

+ (NSArray *)loadInterviewModels;

@end
