//
//  WLCocoaModel.m
//  iOSInformation
//
//  Created by teed on 2017/1/2.
//  Copyright © 2017年 teed. All rights reserved.
//

#import "WLCocoaModel.h"
#import <TFHpple.h>
#import <AFNetworking.h>
#import "QZDateUtil.h"
NSString *const CocoaChinaArticleListURL = @"http://www.cocoachina.com/cms/wap.php?action=more&page=%zd";

@implementation WLCocoaModel

+ (void)loadCocoaModelWithPageIndex:(NSInteger)page andComplete:(void (^)(NSArray *,NSError *))complete
{
    NSString *urlString = [NSString stringWithFormat:CocoaChinaArticleListURL, page];
    [self downloadWithUrlString:urlString andBlock:^(NSData *data, NSError *error) {
        if (error) {
            complete(nil,error);
            return;
        }
        
        TFHpple *hpple = [TFHpple hppleWithHTMLData:data];
        if (!hpple) {
            complete(nil,error);
            return;
        }
        NSArray *liEles = [hpple searchWithXPathQuery:@"//li[@class='articlelist clearfix']"];
        NSMutableArray *models = [NSMutableArray array];
        for (TFHppleElement *liEle in liEles) {
            WLCocoaModel *model = [[WLCocoaModel alloc] init];
            if (!liEle) {
                complete(nil,error);
                return;
            }
            TFHppleElement *aTag = [((TFHppleElement *)[liEle childrenWithTagName:@"p"].firstObject) childrenWithTagName:@"a"].firstObject;
            TFHppleElement *lastATag = [((TFHppleElement *)[((TFHppleElement *)[liEle childrenWithTagName:@"div"].lastObject) childrenWithTagName:@"div"].firstObject) childrenWithTagName:@"a"].firstObject;
            TFHppleElement *imgTag = [lastATag childrenWithTagName:@"img"].firstObject;
            
            TFHppleElement *spanTag = [((TFHppleElement *)[((TFHppleElement *)[((TFHppleElement *)[liEle childrenWithTagName:@"div"].lastObject) childrenWithTagName:@"div"].lastObject) childrenWithTagName:@"p"].lastObject) childrenWithTagName:@"span"].firstObject;
            if (aTag) {
                NSString *title = aTag.attributes[@"title"];
                if (!title) {
                    title = aTag.text;
                }
                if (title) {
                    model.title = title;
                }
                NSString *href = aTag.attributes[@"href"];
                if (href) {
                    model.articleUrl = [NSString stringWithFormat:@"http://www.cocoachina.com/cms/%@",href];
                }
            }
            if (imgTag) {
                model.imgUrl = imgTag.attributes[@"src"];
            }
            
            if (spanTag) {
                model.postTime = spanTag.text;
            }
            [models addObject:model];
        }
        complete([models copy], nil);
    }];
}

- (void)setPostTime:(NSString *)postTime
{
    _postTime = [[QZDateUtil sharedInstance] timeAgoWithDateStr:postTime];
}

#pragma mark --- Private
+ (void)downloadWithUrlString:(NSString *)urlString andBlock:(void(^)(NSData *,NSError *))complete
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSData *htmlData = [NSData dataWithContentsOfURL:filePath];
        [[NSFileManager defaultManager] removeItemAtURL:filePath error:nil];
        if (complete) {
            complete(htmlData, error);
        }
    }];
    [downloadTask resume];
}

@end

@implementation WLCocoaArticleDetailModel


+ (void)loadWithArticleURL:(NSString *)articleURL complete:(void (^)(WLCocoaArticleDetailModel *,NSError *))complete
{
    [self downloadWithUrlString:articleURL andBlock:^(NSData *data, NSError *error) {
        if (error) {
            complete(nil,error);
            return;
        }
        
        TFHpple *hpple = [TFHpple hppleWithHTMLData:data];
        TFHppleElement *body = [hpple searchWithXPathQuery:@"//div[@class='detailcon']"].firstObject;
        if (body) {
            WLCocoaArticleDetailModel *model = [[WLCocoaArticleDetailModel alloc] init];
            NSString *raw = [body.raw stringByReplacingOccurrencesOfString:@"brush:js;toolbar:false" withString:@"exampleiOS"];
            // 给所有img标签添加事件
            raw = [raw stringByReplacingOccurrencesOfString:@"<img src" withString:@"<img onclick='clickImage(this.src)' src"];
            model.content = raw;
            complete(model, nil);
        } else{
            complete(nil, [[NSError alloc] init]);
        }
        
        
        
        
    }];
}

#pragma mark --- Private
+ (void)downloadWithUrlString:(NSString *)urlString andBlock:(void(^)(NSData *,NSError *))complete
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSData *htmlData = [NSData dataWithContentsOfURL:filePath];
        [[NSFileManager defaultManager] removeItemAtURL:filePath error:nil];
        if (complete) {
            complete(htmlData, error);
        }
    }];
    [downloadTask resume];
}

@end

















