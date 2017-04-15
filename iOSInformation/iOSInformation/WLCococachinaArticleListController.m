//
//  WLCococachinaArticleListController.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCococachinaArticleListController.h"
#import "WLCocoachinaListViewCell.h"
#import "WLRefreshHeader.h"
#import "WLCocoaModel.h"
#import "WLArticleDetailViewController.h"
@interface WLCococachinaArticleListController () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation WLCococachinaArticleListController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"文章";
    self.datasource = [NSMutableArray array];
    self.page = 0;
    [self.view addSubview:self.articleListTable];
    __weak typeof(self) weak_self = self;
    self.articleListTable.mj_header = [WLRefreshHeader headerWithRefreshingBlock:^{
        [weak_self fetchData];
    }];
    self.articleListTable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weak_self fetchData];
    }];
    [self.articleListTable.mj_header beginRefreshing];
}



- (void)fetchData
{
    
    // 如果是头部刷新则重置
    if ([self.articleListTable.mj_header isRefreshing]) {
        
        self.page = 0;
    }
    __weak typeof(self) weak_self = self;
    [WLCocoaModel loadCocoaModelWithPageIndex:self.page andComplete:^(NSArray *models, NSError *error) {
        if ([weak_self.articleListTable.mj_header isRefreshing]) {
            [weak_self.datasource removeAllObjects];
        }
        if (error) {
            [weak_self.view addSubview:weak_self.errorLabel];
        } else {
            [weak_self.datasource addObjectsFromArray:models];
            [weak_self.articleListTable reloadData];
        }
        
        
        if ( [weak_self.articleListTable.mj_header isRefreshing]) {
            [weak_self.articleListTable.mj_header endRefreshing];
        }
        
        if ([weak_self.articleListTable.mj_footer isRefreshing]) {
            [weak_self.articleListTable.mj_footer endRefreshing];
        }
        weak_self.page++;
    }];
}





#pragma mark --- 懒加载
- (UILabel *)errorLabel
{
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.text = @"出现错误，点击重试";
        _errorLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [_errorLabel sizeToFit];
        _errorLabel.font = [UIFont systemFontOfSize:15];
        _errorLabel.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5 - 50);
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToRetry)];
        _errorLabel.userInteractionEnabled = YES;
        [_errorLabel addGestureRecognizer:tapGes];
    }
    return _errorLabel;
}

- (UITableView *)articleListTable
{
    if (!_articleListTable) {
        _articleListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44) style:UITableViewStylePlain];
        _articleListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _articleListTable.delegate = self;
        _articleListTable.dataSource = self;
        _articleListTable.rowHeight = 90;
        [_articleListTable registerNib:[UINib nibWithNibName:@"WLCocoachinaListViewCell" bundle:nil] forCellReuseIdentifier:@"WLCocoachinaListViewCell"];
    }
    return _articleListTable;
}


- (void)tapToRetry
{
    [self fetchData];
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLArticleDetailViewController *articleVc = [[WLArticleDetailViewController alloc] init];
    articleVc.cocoa = self.datasource[indexPath.row];
    [self.navigationController pushViewController:articleVc animated:YES];
}


#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCocoachinaListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WLCocoachinaListViewCell"];
    cell.model = self.datasource[indexPath.row];
    return cell;
}

@end

















