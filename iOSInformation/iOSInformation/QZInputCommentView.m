//
//  QZInputCommentView.m
//  QQZQ
//
//  Created by ywl on 16/4/19.
//  Copyright © 2016年 cafuc. All rights reserved.
//

#import "QZInputCommentView.h"
#import "QZPlaceholderTextView.h"
#import "NSString+Size.h"
#import "UIColor+HEX.h"
#import <Masonry.h>
@interface QZInputCommentView() <UITextViewDelegate>

@property (nonatomic, assign) CGFloat maxTextHeight;
@property (nonatomic, assign) CGFloat oneTextHeight;
@property (nonatomic, assign) CGFloat twoTextHeight;
@property (nonatomic, strong) QZPlaceholderTextView *textView;
@end

@implementation QZInputCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextDidChangeNotify:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)reset
{
    [_textView resignFirstResponder];
    _textView.text = @"";
    if ([self.delegate respondsToSelector:@selector(inputCommentViewShouldChangeHeight:andHeight:)]) {
        [self.delegate inputCommentViewShouldChangeHeight:self andHeight:40];
    }
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    
    QZPlaceholderTextView *fdInput = [[QZPlaceholderTextView alloc] init];
    fdInput.enablesReturnKeyAutomatically = YES;
    fdInput.delegate = self;
    self.textView = fdInput;
    fdInput.returnKeyType = UIReturnKeySend;
    fdInput.backgroundColor = [UIColor whiteColor];
    

    self.maxTextHeight = fdInput.font.lineHeight * 3 + 3 * 2;
    self.oneTextHeight = fdInput.font.lineHeight * 1 + 3 * 2;
    self.twoTextHeight = fdInput.font.lineHeight * 2 + 3 * 2;
    
    fdInput.myPlaceholderColor = [UIColor colorWithHexString:@"a3a3a3"];
    fdInput.myPlaceholder = @"   我也说一句...";
    fdInput.placeHolderLabel.font = [UIFont systemFontOfSize:13];
//    fdInput.layer.cornerRadius = 3;
//    fdInput.layer.borderColor = [UIColor colorWithHexString:@"#dedede"].CGColor;
//    fdInput.layer.borderWidth = .5;
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
//      [self sd_addSubviews:@[fdInput, line]];
    
    [self addSubview:fdInput];
    fdInput.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weak_self = self;
    [fdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_self).offset(15);
        make.right.equalTo(weak_self).offset(-15);
        make.top.equalTo(weak_self).offset(5);
        make.bottom.equalTo(weak_self).offset(-5);
    }];

    [self addSubview:line];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_self);
        make.right.equalTo(weak_self);
        make.top.equalTo(weak_self);
        make.height.mas_equalTo(.5f);
    }];
    
}

#pragma mark --- NSNotification Method
- (void)inputTextDidChangeNotify:(NSNotification *)notification
{
    
    CGFloat textHeight = [[NSString stringWithFormat:@"       %@", self.textView.text] heightWithFont:self.textView.font constrainedToWidth:self.width - 40];
    static NSInteger index = 0;
    if (textHeight <= self.oneTextHeight && index != 0) {
          index = 0;
        if ([self.delegate respondsToSelector:@selector(inputCommentViewShouldChangeHeight:andHeight:)]) {
            [self.delegate inputCommentViewShouldChangeHeight:self andHeight:40];
        }
        
    } else if (textHeight <= self.twoTextHeight && textHeight >= self.oneTextHeight && index != 1) {
        index = 1;
        if ([self.delegate respondsToSelector:@selector(inputCommentViewShouldChangeHeight:andHeight:)]) {
            [self.delegate inputCommentViewShouldChangeHeight:self andHeight:50];
        }
    } else if (textHeight > self.twoTextHeight && index != 2) {
        index = 2;
        if ([self.delegate respondsToSelector:@selector(inputCommentViewShouldChangeHeight:andHeight:)]) {
            [self.delegate inputCommentViewShouldChangeHeight:self andHeight:60];
        }
    }
}

#pragma mark --- UITextViewDelegate Method
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
       
        if ([self.delegate respondsToSelector:@selector(inputCommentViewDidClickPost:andContent:)]) {
            [self.delegate inputCommentViewDidClickPost:self andContent:textView.text];
        }
         [self reset];
        return NO;
    }
    return YES;
}

@end















