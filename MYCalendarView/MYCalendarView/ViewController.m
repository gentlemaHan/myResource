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
    self.calendarView.selectedType = selectedType_single;
    [self.view addSubview:self.calendarView];

}

-(void)viewDidLayoutSubviews{
    self.calendarView.frame = CGRectMake(0, 80, 200, 300);
    CGRect frame = self.calendarView.frame;
    frame.size.height = self.calendarView.contentHeight;
    self.calendarView.frame = frame;
}

#pragma mark - MYCalendarViewDelegate

@end
