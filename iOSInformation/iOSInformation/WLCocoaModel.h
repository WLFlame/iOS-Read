//
//  WLCocoaModel.h
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RLMObject.h>
@class WLCocoaArticleDetailModel;
@interface WLCocoaModel : RLMObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *articleUrl;
@property (nonatomic, copy) NSString *postTime;
@property (nonatomic, strong) NSDate *createAt;
@property (nonatomic, strong) WLCocoaArticleDetailModel *articleModel;

+ (void)loadCocoaModelWithPageIndex:(NSInteger)page andComplete:(void(^)(NSArray *models, NSError *error))complete;

@end

@interface WLCocoaArticleDetailModel : RLMObject

@property (nonatomic, copy) NSString *content;

+ (void)loadWithArticleURL:(NSString *)articleURL complete:(void(^)(WLCocoaArticleDetailModel *model,NSError *error))complete;

@end
