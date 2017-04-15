//
//  WLInterviewsViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLInterviewsViewController.h"
#import "WLInterviewModel.h"
#import "WLInterviewSetView.h"
#import "WLAnswerContainerView.h"
#import <Masonry.h>
#import "WLInterviewQuestionUtil.h"

typedef NS_ENUM(NSInteger, InterviewVcSet) {
    InterviewVcSetAnswer,
    InterviewVcSetHideAnswer
};

@interface WLInterviewsViewController () <WLInterviewSetViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *seeAnswerBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextAnswerBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) NSArray *interviews;

@property (nonatomic, assign) NSInteger questionIndex;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) WLInterviewSetView *interviewSetView;
@property (nonatomic, strong) WLAnswerContainerView *answerContainerView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbTitleCenterCos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbTitleTopCos;

@property (nonatomic, assign) InterviewVcSet interviewSet;

@end

@implementation WLInterviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"面试题";
    self.nextBtn.hidden = YES;
    self.questionIndex = 0;
    self.interviews = [WLInterviewQuestionUtil sharedInstance].interviews;
    self.seeAnswerBtn.layer.cornerRadius = 3;
    self.seeAnswerBtn.layer.masksToBounds = YES;
    self.nextAnswerBtn.layer.cornerRadius = 3;
    self.nextAnswerBtn.layer.masksToBounds = YES;
    self.textView.showsVerticalScrollIndicator = NO;
    
    self.interviewSet = InterviewVcSetHideAnswer;
    
    UIButton *setItemBtn = [[UIButton alloc] init];
    [setItemBtn setImage:[UIImage imageNamed:@"icon_menu_settings_pr_23x23_"] forState:UIControlStateNormal];
    [setItemBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setItemBtn];
    [setItemBtn addTarget:self action:@selector(setItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.answerContainerView];
    self.answerContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weak_self = self;
    [self.answerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weak_self.view);
        make.top.equalTo(weak_self.view.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.answerContainerView.hidden = YES;
    [self loadQuestion];
}

- (void)loadQuestion
{
    WLInterviewModel *model = self.interviews[self.questionIndex];
    self.lbTitle.text = model.question;
}

- (void)nextQuestion
{
    self.questionIndex++;
    [self loadQuestion];
    
}

- (void)hideAnwserView
{
    __weak typeof(self) weak_self = self;
    [self.answerContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weak_self.view);
        make.top.equalTo(weak_self.view.mas_bottom);
       
    }];
    self.lbTitleTopCos.active = NO;
    self.lbTitleCenterCos.active = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [weak_self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weak_self.answerContainerView removeFromSuperview];
        weak_self.answerContainerView.hidden = YES;
    }];
}

#pragma mark --- Lazy Load
- (WLAnswerContainerView *)answerContainerView
{
    if (!_answerContainerView) {
        _answerContainerView = [[NSBundle mainBundle] loadNibNamed:@"WLAnswerContainerView" owner:nil options:nil].lastObject;
        __weak typeof(self) weak_self = self;
        [_answerContainerView setOperatorClickHide:^{
            [weak_self hideAnwserView];
        }];
        
    }
    return _answerContainerView;
}

- (WLInterviewSetView *)interviewSetView
{
    if (!_interviewSetView) {
        _interviewSetView = [[NSBundle mainBundle] loadNibNamed:@"WLInterviewSetView" owner:nil options:nil].lastObject;
        _interviewSetView.delegate = self;
        _interviewSetView.frame = CGRectMake(0, 0, self.view.width - 70, 150);
        _interviewSetView.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5 - 70);
    }
    return _interviewSetView;
}

- (IBAction)btnClickSeeAnswer {
    [self.view addSubview:self.answerContainerView];
    self.answerContainerView.model = self.interviews[self.questionIndex];
    self.answerContainerView.hidden = NO;
    self.answerContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weak_self = self;
    [self.answerContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_self.bottomLineView.mas_bottom).offset(10);
        make.left.and.right.and.bottom.equalTo(weak_self.view);
    }];
    self.lbTitleTopCos.active = YES;
    self.lbTitleCenterCos.active = NO;
    [UIView animateWithDuration:0.25 animations:^{
        [weak_self.view layoutIfNeeded];
    }];
}

- (IBAction)btnClickNext {
    [self nextQuestion];
}

- (IBAction)btnClickJustNext:(id)sender {
    [self nextQuestion];
    self.answerContainerView.model = self.interviews[self.questionIndex];
}

- (void)tapGes
{
    [self.effectView removeFromSuperview];
    [self.interviewSetView removeFromSuperview];
}

- (void)setItemClick
{
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.effectView = effectView;
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    [self.view addSubview:self.interviewSetView];
    self.interviewSetView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.25 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.interviewSetView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    effectView.userInteractionEnabled = YES;
    [effectView addGestureRecognizer:tapGes];
    
}

#pragma mark --- WLInterviewSetViewDelegate
- (void)interviewSetViewToSeeAnswer
{
    self.interviewSet = InterviewVcSetAnswer;
    [self tapGes];
    
    self.nextBtn.hidden = NO;
    self.nextAnswerBtn.hidden = YES;
    self.seeAnswerBtn.hidden = YES;
    
    [self.view addSubview:self.answerContainerView];
    self.answerContainerView.hideBtn.hidden = YES;
    self.answerContainerView.model = self.interviews[self.questionIndex];
    self.answerContainerView.hidden = NO;
    self.answerContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weak_self = self;
    [self.answerContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_self.bottomLineView.mas_bottom).offset(10);
        make.left.and.right.equalTo(weak_self.view);
        make.bottom.equalTo(weak_self.nextBtn.mas_top).offset(-10);
    }];
    self.lbTitleTopCos.active = YES;
    self.lbTitleCenterCos.active = NO;
    [UIView animateWithDuration:0.25 animations:^{
        [weak_self.view layoutIfNeeded];
    }];

}

- (void)interviewSetViewToHideAnswer
{
    self.interviewSet = InterviewVcSetHideAnswer;
    [self tapGes];
    self.nextBtn.hidden = YES;
    self.nextAnswerBtn.hidden = NO;
    self.seeAnswerBtn.hidden = NO;
    self.answerContainerView.hideBtn.hidden = NO;
    [self hideAnwserView];
}

@end















