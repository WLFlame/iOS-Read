//
//  WLStyle.h
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLStyle : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, copy) NSString *current_css;
@property (nonatomic, copy) NSString *jquery;
@end
