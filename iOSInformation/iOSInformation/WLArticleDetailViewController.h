//
//  WLArticleDetailViewController.h
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLCocoaModel;
@interface WLArticleDetailViewController : UIViewController
@property (nonatomic, strong) WLCocoaModel *cocoa;
@property (nonatomic, assign) BOOL seletedLike;
@end
