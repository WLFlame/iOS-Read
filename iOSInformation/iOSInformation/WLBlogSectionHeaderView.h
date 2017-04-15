//
//  WLBlogSectionHeaderView.h
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const BlogSectionHeaderDidClickNotification;
@class WLBlogModel;
@interface WLBlogSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) WLBlogModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *trangleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
