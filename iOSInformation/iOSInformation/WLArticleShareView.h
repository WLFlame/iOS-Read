//
//  WLArticleShareView.h
//  iOSInformation
//
//  Created by teed on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLArticleShareView : UIView

@property (nonatomic,copy) void(^operatorShareTo)(NSInteger platform);

@end
