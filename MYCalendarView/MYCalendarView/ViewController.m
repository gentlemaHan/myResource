//
//  ViewController.m
//  MYCalendarView
//
//  Created by 韩小东 on 15/6/3.
//  Copyright (c) 2015年 hanxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "MYCalendarView.h"

@interface ViewController ()

@property (nonatomic,strong)    MYCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarView = [[MYCalendarView alloc] init];
    [self.view addSubview:self.calendarView];
    self.calendarView.backgroundColor = [UIColor greenColor];
}

-(void)viewDidLayoutSubviews{
    self.calendarView.frame = CGRectMake(0, 80, self.view.frame.size.width, 40);
}


@end
