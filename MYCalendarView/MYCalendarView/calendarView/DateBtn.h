//
//  DateBtn.h
//  MYCalendarView
//
//  Created by 韩小东 on 15/6/4.
//  Copyright (c) 2015年 hanxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateBtn : UIView

-(void)setTitle:(NSString *)title forState:(UIControlState)state;
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;

@property (nonatomic,assign)    BOOL enabled;

@end
