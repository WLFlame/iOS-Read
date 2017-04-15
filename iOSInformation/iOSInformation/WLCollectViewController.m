//
//  WLCollectViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/7.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCollectViewController.h"
#import <Realm/Realm.h>
#import <MJRefresh.h>
#import "WLCocoaModel.h"
#import "WLCocoachinaListViewCell.h"
#import "WLArticleDetailViewController.h"
@interface WLCollectViewController ()

@property (nonatomic, strong) RLMResults<WLCocoaModel *> *rlmDataSource;

@end

@implementation WLCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.articleListTable.mj_footer = nil;
}

- (void)fetchData
{
    
    // 如果是头部刷新则重置
    if ([self.articleListTable.mj_header isRefreshing]) {
        self.page = 0;
    }
    
    RLMResults<WLCocoaModel *> *results = [[WLCocoaModel allObjects] sortedResultsUsingProperty:@"createAt" ascending:NO];
    self.rlmDataSource = results;
    if (results.count == 0) {
        self.errorLabel.text = @"暂时还没有任何收藏";
        [self.view addSubview:self.errorLabel];
    } else {
        [self.errorLabel removeFromSuperview];
        [self.articleListTable reloadData];
    }
    [self.articleListTable.mj_header endRefreshing];
    
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLArticleDetailViewController *articleVc = [[WLArticleDetailViewController alloc] init];
    articleVc.cocoa = self.rlmDataSource[indexPath.row];
    articleVc.seletedLike = YES;
    [self.navigationController pushViewController:articleVc animated:YES];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rlmDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCocoachinaListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WLCocoachinaListViewCell"];
    cell.model = self.rlmDataSource[indexPath.row];
    return cell;
}


@end
