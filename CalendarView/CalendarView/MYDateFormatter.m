//
//  MYDateFormatter.m
//  NurseHome
//
//  Created by 韩小东 on 15/5/28.
//  Copyright (c) 2015年 Wuhan Maxtop Electronics Technology Co., Ltd. All rights reserved.
//

#import "MYDateFormatter.h"


static NSDateFormatter *formatter;

@implementation MYDateFormatter

+(NSDate *)dateFromeString:(NSString *)string{
    if (!string) {
        return nil;
    }
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSTimeZone *local = [NSTimeZone localTimeZone];
    NSDate *date = [formatter dateFromString:string];
    
    NSTimeInterval seconds = [local secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:seconds];
    return date;
}

+(NSString *)stringFromeDate:(NSDate *)date{
    if (!date) {
        return nil;
    }
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:@"yyyy-MM-dd"];

    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+(NSDate *)convertDate:(NSDate *)date{
    if (!date) {
        return nil;
    }
//    if (!formatter) {
//        formatter = [[NSDateFormatter alloc] init];
//    }
//    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
//    [formatter setTimeZone:[NSTimeZone localTimeZone]];
//    
//    NSString *dateStr = [formatter stringFromDate:date];
//    
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    NSDate *date2 = [formatter dateFromString:dateStr];
    NSTimeZone *local = [NSTimeZone localTimeZone];
    NSTimeInterval seconds = [local secondsFromGMTForDate:date];
    NSDate *date2 = [date dateByAddingTimeInterval:seconds];
    return date2;
}


+(NSString *)shortStringFromDate:(NSDate *)date{
    if (!date) {
        return nil;
    }
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *str = [formatter stringFromDate:date];
    str = [str substringWithRange:NSMakeRange(0, 10)];
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    return str;
}

+(NSString *)monthDayStringFromDate:(NSDate *)date{
    if (!date) {
        return nil;
    }
    NSString *str = [MYDateFormatter shortStringFromDate:date];
    
    NSString *sub = [str substringWithRange:NSMakeRange(5, 5)];
    NSArray *arr = [sub componentsSeparatedByString:@"/"];
    NSMutableString *tamade = [NSMutableString string];
    for (int i=0; i<arr.count; i++) {
        NSString *s = arr[i];
        if ([s hasPrefix:@"0"]) {
            s = [s substringWithRange:NSMakeRange(1, 1)];
        }
        [tamade appendString:s];
        [tamade appendString:@"月"];
    }
    [tamade replaceCharactersInRange:NSMakeRange(tamade.length-1, 1) withString:@"日"];
    return tamade;
}

@end
