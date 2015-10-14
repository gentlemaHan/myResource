//
//  MYDateFormatter.h
//  NurseHome
//
//  Created by 韩小东 on 15/5/28.
//  Copyright (c) 2015年 Wuhan Maxtop Electronics Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYDateFormatter : NSObject

/**
 *  返回"2015-06-10"样式的日期
 */
+(NSDate *)dateFromeString:(NSString *)string;
/**
 *  返回"2015-05-31"样式的字符串
 */
+(NSString *)stringFromeDate:(NSDate *)date;
/**
 *  将日期转换为当前正确的时区时间
 */
+(NSDate *)convertDate:(NSDate *)date;
/**
 *  返回" 2015/05/12 "样式的字符串
 */
+(NSString *)shortStringFromDate:(NSDate *)date;
/**
 *  返回 " 5月30日 "
 */
+(NSString *)monthDayStringFromDate:(NSDate *)date;

@end
