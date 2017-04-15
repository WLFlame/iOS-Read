//
//  WLMenuTableViewCell.h
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, copy) NSString *seletedImageName;
@end
