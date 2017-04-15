//
//  WLCommentTableViewCell.m
//  iOSInformation
//
//  Created by teed on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCommentTableViewCell.h"

@interface WLCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatart;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation WLCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
