//
//  WLMenuTableViewController.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLMenuTableViewController.h"
#import "WLMenuTableViewCell.h"
#import "WLMenuSectionView.h"
#import "WLMenuFooterSectionView.h"
@interface WLMenuTableViewController ()

@property (nonatomic, strong) NSIndexPath *lastSeletedIndex;

@end

@implementation WLMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WLMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"WLMenuTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *tableHeaderBlankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    self.tableView.tableHeaderView = tableHeaderBlankView;
    UIView *tableFooterBlankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    self.tableView.tableFooterView = tableFooterBlankView;
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"WLMenuSectionView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"WLMenuSectionView"];
    [self.tableView registerClass:[WLMenuFooterSectionView class] forHeaderFooterViewReuseIdentifier:@"WLMenuFooterSectionView"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        self.lastSeletedIndex = indexPath;
    });
    
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.lastSeletedIndex.section == indexPath.section && self.lastSeletedIndex.row == indexPath.row) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(menuTableViewControllerDidSeletedIndex:)]) {
        switch (indexPath.section) {
            case 0:
            {
                [self.delegate menuTableViewControllerDidSeletedIndex:indexPath.row];
            }
                break;
            case 1:
            {
                [self.delegate menuTableViewControllerDidSeletedIndex:indexPath.row + 2];
            }
                break;
            case 2:
            {
                [self.delegate menuTableViewControllerDidSeletedIndex:indexPath.row + 4];
            }
                break;
            case 3:
            {
                [self.delegate menuTableViewControllerDidSeletedIndex:indexPath.row + 6];
            }
                break;
        }
        
    }
    [tableView deselectRowAtIndexPath:self.lastSeletedIndex animated:YES];
    self.lastSeletedIndex = indexPath;
}

#pragma mark --- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    WLMenuFooterSectionView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WLMenuFooterSectionView"];
    footerView.contentView.backgroundColor = [UIColor whiteColor];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    WLMenuSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WLMenuSectionView"];
    switch (section) {
        case 0:
        {
            sectionView.lbSectionTitle.text = @"";
        }
            break;
        case 1:
        {
            sectionView.lbSectionTitle.text = @"ARTICLE";
        }
            break;
        case 2:
        {
            sectionView.lbSectionTitle.text = @"JOB";
        }
            break;
            
        default:
        {
            sectionView.lbSectionTitle.text = @"OTHER";
        }
    }
    return sectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
        case 1:
        {
            return 2;
        }
        case 2:
        {
            return 2;
        }
        default:
        {
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    WLMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WLMenuTableViewCell"];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
//                case 0:
//                {
//                    cell.lbTitle.text = @"搜索";
//                    cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_search_23x23_"];
//                    cell.normalImageName = @"icon_menu_search_23x23_";
//                    cell.seletedImageName = @"icon_menu_search_pr_23x23_";
//                }
//                    break;
                case 0:
                {
                    cell.lbTitle.text = @"收藏";
                    cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_favorites_23x23_"];
                    cell.normalImageName = @"icon_menu_favorites_23x23_";
                    cell.seletedImageName = @"icon_menu_favorites_pr_23x23_";
                }
                    break;
                    
            }
            
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.lbTitle.text = @"CC";
                    cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_report_23x23_"];
                    cell.normalImageName = @"icon_menu_report_23x23_";
                    cell.seletedImageName = @"icon_menu_report_pr_23x23_";
                   
                    
                }
                     break;
                case 1:
                {
                    cell.lbTitle.text = @"Blog";
                    cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_topapps_23x23_"];
                    cell.normalImageName = @"icon_menu_topapps_23x23_";
                    cell.seletedImageName = @"icon_menu_topapps_pr_23x23_";
                }
                     break;
                    
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.lbTitle.text = @"面试题";
                    cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_report_23x23_"];
                    cell.normalImageName = @"icon_menu_report_23x23_";
                    cell.seletedImageName = @"icon_menu_report_pr_23x23_";
                }
                     break;
                case 1:
                {
                    cell.lbTitle.text = @"模拟面试";
                    cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_connections_23x23_"];
                    cell.normalImageName = @"icon_menu_connections_23x23_";
                    cell.seletedImageName = @"icon_menu_connections_pr_23x23_";
                }
                     break;
                    
            }
        }
            break;
        case 3:
        {
            cell.lbTitle.text = @"设置";
            cell.imageIcon.image = [UIImage imageNamed:@"icon_menu_settings_23x23_"];
            cell.normalImageName = @"icon_menu_settings_23x23_";
            cell.seletedImageName = @"icon_menu_settings_pr_23x23_";
        }
             break;
        
    }
    return cell;
}

@end









