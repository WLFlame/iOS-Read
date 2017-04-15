//
//  QZDateUtil.h
//  QQZQ
//
//  Created by ywl on 15/12/31.
//  Copyright © 2015年 cafuc. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QZDateUtil : NSObject
@property (nonatomic, strong) NSDateFormatter *formatter;
+ (instancetype)sharedInstance;
/**
 *  朋友圈时间类型
 *
 */
- (NSString *)formatTime:(NSString *)dateStr;

- (NSString *)formatTimeWithFormat:(NSString *)format andDate:(NSDate *)date;


- (NSString *)timeStringWithDateStr:(NSString *)dateStr andFormat:(NSString *)format;

/**
 *   2016-04-26 13:27:14, 相册多少时间以前
 * */
- (NSString *)timeAgoWithDateStr:(NSString *)dateStr;
/**
 *  创建活动
 *
 */
- (NSDate *)createActivityDateFromStr:(NSString *)dateStr;
//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
-(NSString *)getUTCFormateLocalDate:(NSString *)localDate;
/**
 *  返回距离当前时间的整数, 以一刻钟为单位
 *
 */
- (NSDate *)datefromNowAppendAnHalfAnHour;

/**
 *  转换成服务器时间
 *
 *  @param str 需要转换的字符串
 *
 *  @return 转换之后的字符串
 */
- (NSString *)formateClientDateStr:(NSString *)str;

- (NSString *)activityInnerWithDate:(NSDate *)date;

- (NSString *)activityDetailDate:(NSString *)dateStr;

/**
 *  球队内部活动的时间 旧版
 *
 */
- (NSString *)activityInnerDate:(NSString *)dateStr;

- (BOOL)tokenStrIsAvaliable:(NSString *)tokenStr;

- (NSDate *)formateDateString:(NSString *)dateString andFormate:(NSString *)formateString;

/**
 *  获得当前日期时间
 *
 *  @return 当前时间字符串
 */
- (NSString *)getCurrentDate;
/**
 *  输入格式化字符串比较两个日期的大小
 *
 */
- (NSComparisonResult)comparteToDateWithFormat:(NSString *)format firstDateStr:(NSString *)first secondDateStr:(NSString *)second ;

/**
 *  球队资料时间 ex: 2015年11月11日
 *
 */
- (NSString *)teamMeans:(NSString *)dateStr;
/**
 *  比较活动时间
 *
 *  @param dateStr
 *
 *  @return YES 活动还未开始，活动已开始
 */
- (BOOL)compareTimeNow:(NSString *)dateStr;
@end
