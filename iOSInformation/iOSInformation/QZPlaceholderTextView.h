//
//  QZPlaceholderTextView.h
//  QQZQ
//
//  Created by ywl on 16/2/25.
//  Copyright © 2016年 cafuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZPlaceholderTextView : UITextView
@property(nonatomic,copy) NSString *myPlaceholder;  //文字
@property(nonatomic,strong) UIColor *myPlaceholderColor; //文字颜色
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end
