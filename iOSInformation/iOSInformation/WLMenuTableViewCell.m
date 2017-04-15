//
//  WLMenuTableViewCell.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLMenuTableViewCell.h"

@implementation WLMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithRed:10/255.0 green:108/255.0 blue:212/255.0 alpha:0.10];
        self.lbTitle.textColor = [UIColor colorWithRed:26/255.0 green:114/255.0 blue:209/255.0 alpha:1.0];
        self.imageIcon.image = [UIImage imageNamed:self.seletedImageName];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.lbTitle.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1.0];
        self.imageIcon.image = [UIImage imageNamed:self.normalImageName];
    }
}

@end
