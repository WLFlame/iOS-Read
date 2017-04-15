//
//  WLMenuTableViewController.h
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLMenuTableViewControllerDelegate <NSObject>

- (void)menuTableViewControllerDidSeletedIndex:(NSInteger)index;

@end

@interface WLMenuTableViewController : UITableViewController

@property (nonatomic, weak) id<WLMenuTableViewControllerDelegate> delegate;

@end
