//
//  ViewController.m
//  CalendarView
//
//  Created by 韩小东 on 15/7/6.
//  Copyright (c) 2015年 HXD. All rights reserved.
//

#import "ViewController.h"
#import "NHMyCalendarView.h"

@interface ViewController ()<NHMYCalendarViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NHMyCalendarView *calendar = [[NHMyCalendarView alloc] initWithDataSource:self];
    [self.view addSubview:calendar];
    calendar.weekDayColor = [UIColor redColor];
    calendar.yearColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton*)calendarView:(NHMyCalendarView *)calendarView buttonForDay:(NSDate *)day{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [btn setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
    [btn setTitle:@"a" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor colorWithRed:25/255.0 green:160/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"点选－已选日期－红"] forState:UIControlStateSelected];
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.frame.size.width/2;
    return btn;
}

-(UIButton *)preMonthButtonForCalendarView:(NHMyCalendarView *)calendarView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"点选－日期三角－left"] forState:UIControlStateNormal];
    return btn;
}

-(UIButton *)nextMonthButtonForCalendarView:(NHMyCalendarView *)calendarView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"点选－日期三角－right"] forState:UIControlStateNormal];
    return btn;
}

@end
