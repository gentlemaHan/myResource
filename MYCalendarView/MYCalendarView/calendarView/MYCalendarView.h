//
//  MYCalendarView.h
//  MYCalendarView
//
//  Created by 韩小东 on 15/6/3.
//  Copyright (c) 2015年 hanxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点选模式:多选,单选
 */
typedef enum{
    selectedType_mutable = 0,
    selectedType_single
}CalendarViewSelectedType;

@protocol MYCalendarViewDelegate <NSObject>

@optional
/**
 *  点击了某个日期按钮
 *
 */
-(void)dayBtnClick:(NSDate *)date;
/**
 *  点击了下个月按钮
 *
 */
-(void)nextMonthBtnClick:(id)calendarView;
/**
 *  点击了上个月按钮
 *
 */
-(void)preMonthBtnClick:(id)calendarView;

@end



@interface MYCalendarView : UIView

@property (nonatomic,assign)            id<MYCalendarViewDelegate>delegate;
/**
 *  子视图布局实际上是根据frame.size.with来布局的(即子视图和self.frame的宽适应,但是不一定self.frame的高适应,)
    此属性即表示设置self.frame之后,子视图所需要的最适合高度
    当你设置完frame之后,可以添加如下代码:
    CGRect frame = calendarView.frame;
    frame.size.height = contentHeight;
    calendar.frame = frame;
    来确保宽高都达到最适
 */
@property (nonatomic,assign,readonly)   CGFloat contentHeight;

@property (nonatomic,assign)            CalendarViewSelectedType selectedType;
/**
 *  得到所有已点选的日期
 *
 *  @return NSDate 数组
 */
- (NSMutableArray *)getSelectedDays;
/**
 *  设置不可选的日期
 *
 *  @param days 包含对象为"2015/05/12"样式的数组
 */
- (void)setUnSelectDays:(NSArray *)days;

@end
