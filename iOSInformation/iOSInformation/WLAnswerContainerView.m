//
//  WLAnswerContainerView.m
//  iOSInformation
//
//  Created by teed on 2017/1/7.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLAnswerContainerView.h"
#import "WLInterviewModel.h"
@interface WLAnswerContainerView()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WLAnswerContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.textView.editable = NO;
    self.layer.shadowOffset = CGSizeMake(0, -2);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.15;
}

- (void)setModel:(WLInterviewModel *)model
{
    _model = model;
    self.textView.text = model.answer;
}

- (IBAction)btnClickHide {
    if (self.operatorClickHide) {
        self.operatorClickHide();
    }
}

@end
