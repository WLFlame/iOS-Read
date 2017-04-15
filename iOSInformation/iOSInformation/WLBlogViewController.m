//
//  WLBlogViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/5.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLBlogViewController.h"
#import "WLBlogSectionHeaderView.h"
#import "WLBlogModel.h"
#import "WLBlogTableViewCell.h"
#import "WLWebViewController.h"
@interface WLBlogViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *blogListTable;
@property (nonatomic, strong) NSArray<WLBlogModel *> *dataSource;
@end

@implementation WLBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"博客";
    self.dataSource = [WLBlogModel loadBlogs];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.blogListTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveBlogExpandNotify:) name:BlogSectionHeaderDidClickNotification object:nil];
}

#pragma mark --- Notification
- (void)receiveBlogExpandNotify:(NSNotification *)notification
{
    WLBlogModel *model = notification.object;
    model.expand = !model.expand;
    for (WLBlogModel *m in self.dataSource) {
        if (![m isEqual:model]) {
            m.expand = NO;
        }
    }
    [self.blogListTable reloadData];
}

#pragma mark --- 懒加载
- (UITableView *)blogListTable
{
    if (!_blogListTable) {
        _blogListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _blogListTable.delegate = self;
        _blogListTable.dataSource = self;
        _blogListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_blogListTable registerNib:[UINib nibWithNibName:@"WLBlogSectionHeaderView" bundle:nil
                                     ] forHeaderFooterViewReuseIdentifier:@"WLBlogSectionHeaderView"];
        [_blogListTable registerNib:[UINib nibWithNibName:@"WLBlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"WLBlogTableViewCell"];
        _blogListTable.rowHeight = 44;
    }
    return _blogListTable;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLWebViewController *webVc = [[WLWebViewController alloc] init];
    WLBlogModel *model = self.dataSource[indexPath.section];
    webVc.model = model.subBlogs[indexPath.row];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLBlogSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WLBlogSectionHeaderView"];
    headerView.model = self.dataSource[section];
    
    return headerView;
}


#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLBlogModel *model = self.dataSource[section];
    return model.expand ? model.subBlogs.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WLBlogTableViewCell"];
    cell.lbTitle.text = self.dataSource[indexPath.section].subBlogs[indexPath.row].name;
    return cell;
}

@end
