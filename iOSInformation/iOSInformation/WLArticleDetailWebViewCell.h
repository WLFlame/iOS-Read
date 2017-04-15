//
//  WLArticleDetailWebViewCell.h
//  iOSInformation
//
//  Created by ywl on 2017/1/3.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLCocoaArticleDetailModel;
@interface WLArticleDetailWebViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, copy) void(^contentHeightChanged)(CGFloat height);
@property (nonatomic, strong) WLCocoaArticleDetailModel *articleModel;
- (void)loadArticleDetail:(WLCocoaArticleDetailModel *)model;


@end
