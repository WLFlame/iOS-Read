//
//  QZDateUtil.m
//  QQZQ
//
//  Created by ywl on 15/12/31.
//  Copyright © 2015年 cafuc. All rights reserved.
//

#import "QZDateUtil.h"
#import "NSDate+TimeAgo.h"
@interface QZDateUtil()

@end

@implementation QZDateUtil
static QZDateUtil *_instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[QZDateUtil alloc] init];
    });
    return _instance;
}

- (NSDate *)formateDateString:(NSString *)dateString andFormate:(NSString *)formateString
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = formateString;
    
    return [formatter dateFromString:dateString];
}

- (NSString *)timeStringWithDateStr:(NSString *)dateStr andFormat:(NSString *)format
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}



- (NSString *)formatTimeWithFormat:(NSString *)format andDate:(NSDate *)date
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

- (NSString *)timeStringWithFormat:(NSString *)format andDateString:(NSString *)dateString
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = format;
    return [self.formatter stringFromDate:date];
}

- (NSString *)timeAgoWithDateStr:(NSString *)dateStr
{
    NSAssert(dateStr != nil, @"dateStr can't be nil");
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:dateStr];
    return [date timeAgo];
}

- (NSDate *)createActivityDateFromStr:(NSString *)dateStr
{
    NSDateFormatter *formater = self.formatter;
    formater.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formater dateFromString:dateStr];
}
//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
-(NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
-(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

- (BOOL)tokenStrIsAvaliable:(NSString *)tokenStr
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    NSDate *date = [formatter dateFromString:tokenStr];
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
    if (interval >= 3600 * 24) {
        return NO;
    }
    return YES;
}
- (NSDate *)datefromNowAppendAnHalfAnHour
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents * components = [calendar components:unit fromDate:date];
    components.minute -= (components.minute % 30);
    components.minute += 30;
    if (components.minute == 60) {
        components.minute = 0;
        components.hour += 1;
    }
    return [calendar dateFromComponents:components];
}

- (NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeZone:[NSTimeZone localTimeZone]];
        NSArray *weekdayAry = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        [_formatter  setShortWeekdaySymbols:weekdayAry];
    }
    return _formatter;
}

- (NSString *)getCurrentDate
{
    NSDate *date = [NSDate date];
    [self.formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString* formate = [self.formatter stringFromDate:date];
    
    return formate;
}

- (NSComparisonResult)comparteToDateWithFormat:(NSString *)format firstDateStr:(NSString *)first secondDateStr:(NSString *)second
{
    NSString *fmt = @"";
    if (format == nil) {
        fmt = @"yyyy-MM-dd HH:mm:ss";
    } else {
        fmt = format;
    }
    NSDate *date = [self.formatter dateFromString:first];
    switch ([date compare:[self.formatter dateFromString:second]]) {
        case NSOrderedSame:
            return NSOrderedSame;
        case NSOrderedAscending:
            return NSOrderedDescending;
        default:
            return NSOrderedAscending;
    }
}

- (BOOL)compareTimeNow:(NSString *)dateStr
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    switch ([date compare:[NSDate date]]) {
        case NSOrderedSame:
            return NO;
        case NSOrderedAscending:
            return NO;
        default:
            return YES;
    }
}

- (NSString *)formateClientDateStr:(NSString *)str
{
    NSDateFormatter *dateformatter  = self.formatter;
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    NSDate *date = [dateformatter dateFromString:str];
    [dateformatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString* formate = [dateformatter stringFromDate:date];
    
    return formate;
}

/**
 *  球队资料时间
 *
 */
- (NSString *)teamMeans:(NSString *)dateStr
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSDateComponents * components = [calendar components:unit fromDate:date];
    NSString * time = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)components.year, components.month, (long)components.day];
    return time;
}

- (NSString *)activityInnerWithDate:(NSDate *)dates
{
//    dates = [dates dateByAddingHours:-8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    formatter.dateFormat = @"HH";
    NSString* formate = [formatter stringFromDate:dates];
    NSArray *formateArr = [formate componentsSeparatedByString:@" "];
    NSString *weak = [self getWeak:[formateArr[1] integerValue]];
    formate = [NSString stringWithFormat:@"%@ %@ %@",formateArr[0], weak, formateArr[2]];
    return formate;
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

- (NSString *)activityDetailDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"yyyy年MM月dd日 eee HH:mm"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

/**
 *  球队内部活动时间
 *
 */
- (NSString *)activityInnerDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = self.formatter;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"MM月dd日 eee HH:mm"];
    NSString *time = [formatter stringFromDate:date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
//    NSDateComponents * components = [calendar components:unit fromDate:date];
//    NSString * time = [NSString stringWithFormat:@"%ld月%ld日 %@ %02ld:%02ld", (long)components.month, (long)components.day, [self getWeak:(long)components.weekday], (long)components.hour, (long)components.minute];
    return time;
}

- (NSString *)getWeak:(NSInteger)week
{
    switch (week) {
        case 0:
            return @"周日";
            break;
        case 1:
            return @"周一";
            break;
        case 2:
            return @"周二";
            break;
        case 3:
            return @"周三";
            break;
        case 4:
            return @"周四";
            break;
        case 5:
            return @"周五";
            break;
            
        default:
            return @"周六";
            break;
    }
}
@end
