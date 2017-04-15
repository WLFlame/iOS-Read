//
//  WLCommentBottomView.m
//  iOSInformation
//
//  Created by teed on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCommentBottomView.h"

@interface WLCommentBottomView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *commentField;

@end

@implementation WLCommentBottomView

+ (instancetype)commentBottomView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WLCommentBottomView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.commentField.delegate = self;
}

@end
