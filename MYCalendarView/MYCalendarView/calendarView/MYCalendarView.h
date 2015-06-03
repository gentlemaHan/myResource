//
//  MYCalendarView.h
//  MYCalendarView
//
//  Created by 韩小东 on 15/6/3.
//  Copyright (c) 2015年 hanxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    selectedType_mutable = 0,
    selectedType_single
}CalendarViewSelectedType;

@protocol MYCalendarViewDelegate <NSObject>

-(void)dayBtnClick:(NSDate *)date;
@optional
-(void)nextMonthBtnClick:(id)calendarView;
-(void)preMonthBtnClick:(id)calendarView;

@end



@interface MYCalendarView : UIView

@property (nonatomic,assign)    id<MYCalendarViewDelegate>delegate;
@property (nonatomic,assign)    CGFloat contentHeight;
@property (nonatomic,assign)    CalendarViewSelectedType selectedType;

- (NSMutableArray *)getSelectedDays;
- (void)setUnSelectDays:(NSArray *)days;

@end
