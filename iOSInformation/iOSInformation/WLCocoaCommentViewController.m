//
//  WLCocoaCommentViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/4.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCocoaCommentViewController.h"
#import "QZInputCommentView.h"
#import <Masonry.h>
#import "WLCommentTableViewCell.h"
@interface WLCocoaCommentViewController () <UITableViewDelegate, UITableViewDataSource, QZInputCommentViewDelegate>

@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, strong) UILabel *nodataLabel;
@property (nonatomic, strong) QZInputCommentView *commentBottomView;
@end

@implementation WLCocoaCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveKeyboardWillShowNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveKeyboardWillHideNotify:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.commentTableView];
    self.title = @"评论";
    [self.view addSubview:self.nodataLabel];
    [self.view addSubview:self.commentBottomView];
    self.commentBottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.commentBottomView.delegate = self;
    __weak typeof(self) weak_self = self;
    [self.commentBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(weak_self.view);
        make.height.mas_equalTo(44);
    }];
    [self.commentTableView registerNib:[UINib nibWithNibName:@"WLCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"WLCommentTableViewCell"];
    
}

#pragma mark --- 懒加载
- (QZInputCommentView *)commentBottomView
{
    if (!_commentBottomView) {
        _commentBottomView = [[QZInputCommentView alloc] init];
    }
    return _commentBottomView;
}

- (UITableView *)commentTableView
{
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.tableFooterView = [[UIView alloc] init];
        _commentTableView.estimatedRowHeight = 90;
        _commentTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _commentTableView;
}

- (UILabel *)nodataLabel
{
    if (!_nodataLabel) {
        _nodataLabel = [[UILabel alloc] init];
        _nodataLabel.text = @"还没有人评论，快来抢沙发";
        _nodataLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _nodataLabel.font = [UIFont systemFontOfSize:15];
        [_nodataLabel sizeToFit];
        _nodataLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5 - 50);
    }
    return _nodataLabel;
}

#pragma mark --- UITableViewDelegate
#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark --- QZInputCommentViewDelegate
- (void)inputCommentViewShouldChangeHeight:(QZInputCommentView *)inputView andHeight:(CGFloat)height
{
    [inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [inputView layoutIfNeeded];
    }];
}

- (void)inputCommentViewDidClickPost:(QZInputCommentView *)inputView andContent:(NSString *)content
{
    
}

#pragma mark --- Notification
- (void)receiveKeyboardWillShowNotify:(NSNotification *)notification
{
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    __weak typeof(self) weak_self = self;
    [self.commentBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weak_self.view).offset(-endFrame.size.height);
//        make.left.and.right.equalTo(weak_self.view);
//        make.height.mas_equalTo(44);
    }];
    [UIView animateWithDuration:duration animations:^{
        [weak_self.view layoutIfNeeded];
    }];
}


- (void)receiveKeyboardWillHideNotify:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    __weak typeof(self) weak_self = self;
    [self.commentBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weak_self.view);
        //        make.left.and.right.equalTo(weak_self.view);
        //        make.height.mas_equalTo(44);
    }];
    [UIView animateWithDuration:duration animations:^{
        [weak_self.view layoutIfNeeded];
    }];
}

@end



















