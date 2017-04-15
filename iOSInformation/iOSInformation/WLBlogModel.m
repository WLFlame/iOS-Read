//
//  WLBlogModel.m
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLBlogModel.h"

@implementation WLBlogModel

+ (NSArray *)loadBlogs
{
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blogs" ofType:@"plist"]];
    NSMutableArray *blogModels = [NSMutableArray array];
    for (NSDictionary *dic in plistArray) {
        WLBlogModel *blog = [[WLBlogModel alloc] init];
        blog.name = dic[@"name"];
        NSMutableArray *subBlogModels = [NSMutableArray array];
        for (NSDictionary *subDic in dic[@"sub"]) {
            WLBlogSubModel *subModel = [[WLBlogSubModel alloc] init];
            subModel.name = subDic[@"name"];
            subModel.url = subDic[@"url"];
            [subBlogModels addObject:subModel];
        }
        blog.subBlogs = [subBlogModels copy];
        [blogModels addObject:blog];
    }
    return blogModels;
    
}

@end

@implementation WLBlogSubModel



@end
