//
//  NSString+Suger.m
//  NowExercise
//
//  Created by Suger on 17/4/19.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "NSString+Suger.h"

#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Suger)

+ (NSString *)dateToString:(NSString *)date {
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    // 进行转换
    NSTimeInterval time = [date doubleValue] + 28800;
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dateStr = [matter stringFromDate:Date];
    return dateStr;
}
+ (NSString *)dateToString:(NSString *)date Format:(NSString *)format{
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:format];
    // 进行转换
    NSTimeInterval time = [date doubleValue] + 28800;
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dateStr = [matter stringFromDate:Date];
    return dateStr;
}



+ (NSString *)stringToDate:(NSString *)dateStr {
    
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    NSTimeInterval time = [dateStr doubleValue];
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    // 进行转换
    NSString *date = [matter stringFromDate:Date];
    
    return date;
}

+ (NSString *)stringToDate:(NSString *)dateStr Format:(NSString *)format{
    
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:format];
    NSTimeInterval time = [dateStr doubleValue];
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    // 进行转换
    NSString *date = [matter stringFromDate:Date];
    
    return date;
}

- (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[32];
    
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16], result[17],result[18], result[19],
            result[20], result[21],result[22], result[23],
            result[24], result[25],result[26], result[27],
            result[28], result[29],result[30], result[31]];
    
}



@end
