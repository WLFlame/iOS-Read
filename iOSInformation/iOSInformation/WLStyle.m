//
//  WLStyle.m
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLStyle.h"


@interface WLStyle()

@property (nonatomic, copy) NSString *BASE_CSS;
@property (nonatomic, copy) NSString *FONT_CSS;
@property (nonatomic, copy) NSString *DARK_CSS;
@property (nonatomic, copy) NSString *LIGHT_CSS;



@end

@implementation WLStyle
static WLStyle *_instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WLStyle alloc] init];
        
    });
    return _instance;
}


- (instancetype)init
{
    if (self = [super init]) {
        self.BASE_CSS = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"baseStyle" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil] ;
        self.FONT_CSS = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"baseStyle" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
        self.DARK_CSS = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"baseStyle" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
        self.LIGHT_CSS = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"baseStyle" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
        self.current_css = self.BASE_CSS;
        self.jquery = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jquery-1.6.4.min" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    }
    return self;
}



@end




































