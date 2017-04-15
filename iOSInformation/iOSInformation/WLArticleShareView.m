//
//  WLArticleShareView.m
//  iOSInformation
//
//  Created by teed on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLArticleShareView.h"

@implementation WLArticleShareView


- (IBAction)btnClickShareToPlatform:(UIButton *)sender {
    if (self.operatorShareTo) {
        self.operatorShareTo(sender.tag);
    }
}

@end
