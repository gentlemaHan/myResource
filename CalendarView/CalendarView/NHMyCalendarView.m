//
//  NHMyCalendarView.m
//  NurseHome
//
//  Created by 韩小东 on 15/5/19.
//  Copyright (c) 2015年 Wuhan Maxtop Electronics Technology Co., Ltd. All rights reserved.
//

#import "NHMyCalendarView.h"
#import "MYDateFormatter.h"

const CGFloat leftBtnWidth = 15;
const CGFloat yearLabelHeight = 40;
const CGFloat spaceH = 10;

@implementation NHMyCalendarView
{
    NSCalendar          *_calendar;
    NSDate              *_calendarDate;
    NSCalendarUnit      _dayInfoUnits;
    
    UILabel             *_yearMonthLabel;
    UIButton            *_leftBtn;
    UIButton            *_rightBtn;
    
    CGFloat             _btnFrameWidth;
    NSArray             *_shortWeekdaySymbols;
    NSMutableArray      *_daysInCurrentMonth;
    NSMutableArray      *_selectedDays;
    NSMutableArray      *_selectedBtns;
    NSArray             *_unSelectedDays;
//    BOObL                _needResetSubviewFrame;
}

- (instancetype)initWithDataSource:(id<NHMYCalendarViewDataSource>)dataSource{
    self = [self initWithFrame:CGRectMake(0, 0, 320, 300) DataSource:dataSource];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame DataSource:(id<NHMYCalendarViewDataSource>)dataSource{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
        self.layer.masksToBounds = YES;
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        _dayInfoUnits = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        _calendarDate = [NSDate date];
        _selectedType = selectedType_mutable;
        
        _daysInCurrentMonth = [NSMutableArray array];
        _selectedDays = [NSMutableArray array];
        _selectedBtns = [NSMutableArray array];
//        _needResetSubviewFrame = YES;
        [self initSubViews];
        [self setSubFrame:frame];
        [self setMonth];
    }
    return self;
}

-(void)setYearColor:(UIColor *)yearColor{
    _yearMonthLabel.textColor = yearColor;
}

-(void)setWeekDayColor:(UIColor *)weekDayColor{
    _weekDayColor = weekDayColor;
    [_shortWeekdaySymbols enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *la = (UILabel *)[self viewWithTag:100+idx];
        la.textColor = _weekDayColor;
    }];
}
#pragma mark -
- (void)initSubViews{
    
    _yearMonthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    if (self.yearColor) {
        _yearMonthLabel.textColor = self.yearColor;
    }
    _yearMonthLabel.textAlignment = NSTextAlignmentCenter;
    [_yearMonthLabel setTextColor:[UIColor colorWithRed:25/255.0 green:160/255.0 blue:133/255.0 alpha:1]];
    [self addSubview:_yearMonthLabel];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(preMonthButtonForCalendarView:)]) {
        _leftBtn = [self.dataSource preMonthButtonForCalendarView:self];
    }else{
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"点选－日期三角－left"] forState:UIControlStateNormal];
    }
    [self addSubview:_leftBtn];
    [_leftBtn addTarget:self action:@selector(preMonth) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(nextMonthButtonForCalendarView:)]) {
        _rightBtn = [self.dataSource nextMonthButtonForCalendarView:self];
    }else{
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"点选－日期三角－right"] forState:UIControlStateNormal];
    }
    [self addSubview:_rightBtn];
    [_rightBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    
    
    _shortWeekdaySymbols = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    [_shortWeekdaySymbols enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *la = [[UILabel alloc] init];
        if (self.weekDayColor) {
            la.textColor = self.weekDayColor;
        }
        la.textAlignment = NSTextAlignmentCenter;
        la.text = obj;
        la.tag = 100+idx;
        [self addSubview:la];
        if (self.weekendColor && (idx == 0 || idx == 6)) {
            la.textColor = self.weekendColor;
        }
    }];
}

- (void)setSubFrame:(CGRect)frame{
//    if (!_needResetSubviewFrame) {
//        return;
//    }
    _btnFrameWidth = frame.size.width / 9;

    _yearMonthLabel.frame = CGRectMake((frame.size.width-frame.size.width/3)/2, 0, frame.size.width/3, yearLabelHeight);
    
    _leftBtn.frame = CGRectMake(_yearMonthLabel.frame.origin.x-leftBtnWidth-spaceH, (yearLabelHeight-leftBtnWidth)/2, leftBtnWidth, leftBtnWidth);
    
    _rightBtn.frame = CGRectMake(_yearMonthLabel.frame.origin.x+_yearMonthLabel.frame.size.width+spaceH, _leftBtn.frame.origin.y, leftBtnWidth, leftBtnWidth);
    
    [_shortWeekdaySymbols enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSInteger tag = 100+idx;
        UIView *view = [self viewWithTag:tag];
        view.frame = CGRectMake(_btnFrameWidth*idx+_btnFrameWidth,
                   _yearMonthLabel.frame.origin.y+_yearMonthLabel.frame.size.height,
                   _btnFrameWidth, _btnFrameWidth);
    }];
    for (int i=0; i<_daysInCurrentMonth.count;i++) {
        UIButton *btn = [_daysInCurrentMonth objectAtIndex:i];
        UIView *view = btn.superview;
        NSDateComponents *components = [_calendar components:_dayInfoUnits fromDate:_calendarDate];
        components.day = 1;
        NSDate *firtDayOfMonth = [_calendar dateFromComponents:components];
        NSDateComponents *coms = [_calendar components:NSWeekdayCalendarUnit fromDate:firtDayOfMonth];
        NSInteger weekdayBeginning = [coms weekday];
        CGFloat x = ((weekdayBeginning+i-1)%7);
        CGFloat y = ((weekdayBeginning+i-1)/7);
        view.frame = CGRectMake(x*_btnFrameWidth+_btnFrameWidth,
                                y*_btnFrameWidth+_yearMonthLabel.frame.origin.y+_yearMonthLabel.frame.size.height+_btnFrameWidth,
                                _btnFrameWidth,
                                _btnFrameWidth);
    }
}
#pragma mark -

- (void)setMonth{
    [_selectedDays removeAllObjects];
    NSDateComponents *components = [_calendar components:_dayInfoUnits fromDate:_calendarDate];
    
    _yearMonthLabel.text = [NSString stringWithFormat:@"%ld 年 %ld 月",components.year,components.month];
    
    components.day = 1;
    NSDate *firtDayOfMonth = [_calendar dateFromComponents:components];
    
    NSDateComponents *coms = [_calendar components:NSWeekdayCalendarUnit fromDate:firtDayOfMonth];
    NSInteger weekdayBeginning = [coms weekday];
    NSRange days = [_calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:_calendarDate];
    NSInteger monthLength = days.length;
    
    for (int i=0; i<_daysInCurrentMonth.count; i++) {
        UIButton *btn = [_daysInCurrentMonth objectAtIndex:i];
        [btn removeFromSuperview];
    }
    [_daysInCurrentMonth removeAllObjects];
    for (NSInteger i = 0; i < monthLength; i++) {
        components.day = i+1;
        CGFloat x = ((weekdayBeginning+i-1)%7);
        CGFloat y = ((weekdayBeginning+i-1)/7);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x*_btnFrameWidth+_btnFrameWidth,
                                                                y*_btnFrameWidth+_yearMonthLabel.frame.origin.y+_yearMonthLabel.frame.size.height+_btnFrameWidth,
                                                                _btnFrameWidth,
                                                                _btnFrameWidth)];
        _contentHeight = view.frame.origin.y+view.frame.size.height;
        [view setBackgroundColor:[UIColor clearColor]];
        
        NSDate *today = [NSDate date];
        NSString *todayStr = [MYDateFormatter stringFromeDate:today];
        NSDate *comsDate = [_calendar dateFromComponents:components];
        NSString *comsDateStr = [MYDateFormatter stringFromeDate:comsDate];
        
        today = [MYDateFormatter dateFromeString:todayStr];
        comsDate = [MYDateFormatter dateFromeString:comsDateStr];
        
        NSString *comsStr = [MYDateFormatter shortStringFromDate:comsDate];
        
        UIButton *btn;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(calendarView:buttonForDay:)]) {
            btn = [self.dataSource calendarView:self buttonForDay:comsDate];
        }else{
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor colorWithRed:25/255.0 green:160/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"点选－已选日期－红"] forState:UIControlStateSelected];
            
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = btn.frame.size.width/2;
            
            if ([today compare:comsDate] != NSOrderedDescending) {
                for (NSString *unselectDay in _unSelectedDays) {
                    if ([unselectDay isEqualToString:comsStr]) {
                        btn.enabled = NO;
                        [btn setBackgroundImage:[UIImage imageNamed:@"点选－不可选日期－灰"]forState:UIControlStateDisabled];
                        break;
                    }
                }
            }else {
                btn.enabled = NO;
            }
        }
        btn.frame = CGRectMake(3,3,_btnFrameWidth-6,_btnFrameWidth-6);
        [btn addTarget:self action:@selector(dayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = components.day;
        
        [view addSubview:btn];
        [self addSubview:view];
        
        [_daysInCurrentMonth addObject:btn];
    }
    CGRect frame = self.frame;
    frame.size.height = _contentHeight;
    self.frame = frame;
}

- (void)nextMonth{
    NSDateComponents *components = [_calendar components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month ++;
    NSDate * nextMonthDate =[_calendar dateFromComponents:components];
    _calendarDate = nextMonthDate;
    [self setMonth];
    if (self.delegate && [self.delegate respondsToSelector:@selector(nextMonthBtnClick:)]) {
        [self.delegate nextMonthBtnClick:self];
    }
}

- (void)preMonth{
    NSDateComponents *components = [_calendar components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month --;
    NSDate * prevMonthDate = [_calendar dateFromComponents:components];
    _calendarDate = prevMonthDate;
    [self setMonth];
    if (self.delegate && [self.delegate respondsToSelector:@selector(preMonthBtnClick:)]) {
        [self.delegate preMonthBtnClick:self];
    }
}

#pragma mark - 

-(void)dayBtnClick:(UIButton *)sender{
    NSInteger tag = sender.tag;
    NSDateComponents *coms = [_calendar components:_dayInfoUnits fromDate:_calendarDate];
    coms.day = tag;
    NSDate *date = [_calendar dateFromComponents:coms];
    
    NSDate *date2 = [MYDateFormatter convertDate:date];
    
    sender.selected = !sender.selected;
    
    if (self.selectedType == selectedType_mutable) {
        if (sender.selected) {
            [_selectedDays addObject:date2];
            [_selectedBtns addObject:sender];
        }else{
            [_selectedDays removeObject:date2];
            [_selectedBtns removeObject:sender];
        }
    }else{
        if (sender.selected) {
            [_selectedBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *btn = (UIButton *)obj;
                [btn setSelected:NO];
            }];
            [_selectedBtns removeAllObjects];
            [_selectedBtns addObject:sender];
            
            [_selectedDays removeAllObjects];
            [_selectedDays addObject:date2];
        }else{
            [_selectedBtns removeObject:sender];
            [_selectedDays removeObject:date2];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dayBtnClick:)]) {
        [self.delegate dayBtnClick:date2];
    }
}

-(NSMutableArray *)getSelectedDays{
    return _selectedDays;
}

- (void)setFrame:(CGRect)frame{
//    if (frame.size.width != self.frame.size.width) {
//        _needResetSubviewFrame = YES;
//    }else{
//        _needResetSubviewFrame = NO;
//    }
    [super setFrame:frame];
    [self setSubFrame:frame];
}
#pragma mark - 
-(void)setUnSelectDays:(NSArray *)days{
    _unSelectedDays = [NSArray arrayWithArray:days];
    [self setMonth];
}

@end
