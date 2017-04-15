//
//  WLBlogSectionHeaderView.m
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLBlogSectionHeaderView.h"
#import "WLBlogModel.h"
NSString *const BlogSectionHeaderDidClickNotification = @"BlogSectionHeaderDidClickNotification";
@interface WLBlogSectionHeaderView()


@end

@implementation WLBlogSectionHeaderView


- (void)setModel:(WLBlogModel *)model
{
    _model = model;
    self.titleLabel.text = model.name;
    if (model.expand) {
        self.trangleImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.trangleImageView.transform = CGAffineTransformIdentity;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesClick)];
    [self.contentView addGestureRecognizer:tapGes];
    self.contentView.userInteractionEnabled = YES;
}

- (void)tapGesClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BlogSectionHeaderDidClickNotification object:self.model];
}

@end
