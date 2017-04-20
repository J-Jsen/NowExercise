//
//  NSString+Suger.h
//  NowExercise
//
//  Created by Suger on 17/4/19.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Suger)
/**
 时间戳字符串转年月日 固定转换格式(年-月-日 时:分:秒 毫秒)

 @param date 时间戳字符串
 @return 年 月 日 时 分 秒 毫秒
 */
+ (NSString *)dateToString:(NSString *)date;
/**
 时间戳字符串转年月日 固定格式

 @param dateStr 时间戳字符串(eg:1368082020)
 @return 年月日
 */
+ (NSString *)stringToDate:(NSString *)dateStr;



/**
 年月日转时间戳字符串 自定义格式(yyyy-MM-dd hh:mm:ss zzz)

 @param date 时间戳字符串
 @param format 格式(yyyy-MM-dd hh:mm:ss zzz)
 @return 时间戳字符串
 */
+ (NSString *)dateToString:(NSString *)date Format:(NSString *)format;
/**
 年月日转时间戳字符串

 @param dateStr 字符串(2001-11-11 12:11:44 565)
 @param format 格式(yyyy-MM-dd hh:mm:ss zzz)
 @return 时间戳时间戳
 */
+ (NSString *)stringToDate:(NSString *)dateStr Format:(NSString *)format;

/**
 md5加密
 
 @param str 加密字符串
 @return 32位字符
 */
- (NSString *)md5:(NSString *)str;

@end
