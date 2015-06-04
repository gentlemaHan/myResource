//
//  ViewController.m
//  MYCalendarView
//
//  Created by 韩小东 on 15/6/3.
//  Copyright (c) 2015年 hanxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "MYCalendarView.h"

@interface ViewController ()<MYCalendarViewDelegate>

@property (nonatomic,strong)    MYCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarView = [[MYCalendarView alloc] init];
    self.calendarView.delegate = self;
    self.calendarView.backgroundColor = [UIColor greenColor];
//    self.calendarView.selectedType = selectedType_single;
    [self.view addSubview:self.calendarView];

}

-(void)viewDidLayoutSubviews{
    self.calendarView.frame = CGRectMake(0, 80, 200, 300);
    [self configCalendarViewFrame];
}

-(void)configCalendarViewFrame{
    CGRect frame = self.calendarView.frame;
    frame.size.height = self.calendarView.contentHeight;
    self.calendarView.frame = frame;
}

#pragma mark - MYCalendarViewDelegate

-(void)dayBtnClick:(NSDate *)date{
//    NSLog(@"===date:%@",date);
    NSArray *arr = [self.calendarView getSelectedDays];
    NSLog(@"===selectedDates:%@",arr);
}

-(void)nextMonthBtnClick:(id)calendarView{
    [self configCalendarViewFrame];
}

-(void)preMonthBtnClick:(id)calendarView{
    [self configCalendarViewFrame];
}

@end
