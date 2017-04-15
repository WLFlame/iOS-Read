//
//  WLBlogModel.h
//  iOSInformation
//
//  Created by teed on 2017/1/6.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLBlogSubModel;
@interface WLBlogModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<WLBlogSubModel *> *subBlogs;

// 是否已经展开
@property (nonatomic, assign) BOOL expand;

+ (NSArray *)loadBlogs;

@end

@interface WLBlogSubModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;

@end
