//
//  WLSimulatorInterviewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/7.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLSimulatorInterviewController.h"

@interface WLSimulatorInterviewController ()

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation WLSimulatorInterviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模拟面试";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tipLabel];
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"模拟面试功能即将推出，敬请期待";
        _tipLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [_tipLabel sizeToFit];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5 - 50);
    }
    return _tipLabel;
}



@end
