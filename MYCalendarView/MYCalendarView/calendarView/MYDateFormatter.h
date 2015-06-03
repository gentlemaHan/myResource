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
 *  处理从日历控件点击的日期为现在时间前一天
 */
+(NSDate *)convertDate:(NSDate *)date;
/**
 *  返回" 2015/05/12 "样式的字符串
 */
+(NSString *)stringFromDate:(NSDate *)date;
/**
 *  返回 " 5月30日 "
 */
+(NSString *)monthDayStringFromDate:(NSDate *)date;

@end
