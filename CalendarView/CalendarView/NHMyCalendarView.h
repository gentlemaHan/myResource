//
//  NHMyCalendarView.h
//  NurseHome
//
//  Created by 韩小东 on 15/5/19.
//  Copyright (c) 2015年 Wuhan Maxtop Electronics Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    selectedType_mutable = 0,
    selectedType_single
}CalendarViewSelectedType;

@protocol NHMYCalendarViewDelegate <NSObject>
@optional

-(void)dayBtnClick:(NSDate *)date;
-(void)nextMonthBtnClick:(id)calendarView;
-(void)preMonthBtnClick:(id)calendarView;

@end

@class NHMyCalendarView;
@protocol NHMYCalendarViewDataSource <NSObject>

-(UIButton *)calendarView:(NHMyCalendarView*)calendarView buttonForDay:(NSDate*)day;
-(UIButton *)preMonthButtonForCalendarView:(NHMyCalendarView*)calendarView;
-(UIButton *)nextMonthButtonForCalendarView:(NHMyCalendarView*)calendarView;

@end



@interface NHMyCalendarView : UIView

/**
 *  用下面两个方法初始化
 */
-(instancetype)initWithDataSource:(id<NHMYCalendarViewDataSource>)dataSource;
-(instancetype)initWithFrame:(CGRect)frame DataSource:(id<NHMYCalendarViewDataSource>)dataSource;

@property (nonatomic,assign)    id<NHMYCalendarViewDelegate> delegate;
@property (nonatomic,assign)    id<NHMYCalendarViewDataSource> dataSource;
/**
 *  当你设置完日历控件的frame后,它的高度也许并不等于你设置的高度,但它的宽度一定等于你设置的宽度,此属性才是显示之后日历控件的真实高度.
 */
@property (nonatomic,assign)    CGFloat contentHeight;
/**
 *  星期几那行字的颜色
 */
@property (nonatomic,strong)    UIColor *weekDayColor;
/**
 *  星期那行字周六周日的颜色,可不设
 */
@property (nonatomic,strong)    UIColor *weekendColor;
/**
 *  年份颜色
 */
@property (nonatomic,strong)    UIColor *yearColor;

/**
 *  选择模式(单选和多选)
 */
@property (nonatomic,assign)    CalendarViewSelectedType selectedType;
/**
 *  获得所有已选择的日期
 */
- (NSMutableArray *)getSelectedDays;
/**
 *  设置所有不可选的日期(当前日期以前的所有日期默认不可选)
 */
- (void)setUnSelectDays:(NSArray *)days;

@end


