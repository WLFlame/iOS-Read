//
//  WLCococachinaArticleListController.h
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLBaseContentViewController.h"

@interface WLCococachinaArticleListController : WLBaseContentViewController

@property (nonatomic, strong) UITableView *articleListTable;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UILabel *errorLabel;

- (void)fetchData;

@end
