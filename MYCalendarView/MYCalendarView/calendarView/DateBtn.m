//
//  DateBtn.m
//  MYCalendarView
//
//  Created by 韩小东 on 15/6/4.
//  Copyright (c) 2015年 hanxiaodong. All rights reserved.
//

#import "DateBtn.h"

@implementation DateBtn
{
    UIButton    *_btn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(3, 3, frame.size.width-6, frame.size.height-6);
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = _btn.frame.size.width/2;
        [_btn setTitleColor:[UIColor colorWithRed:25/255.0 green:160/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        [_btn setBackgroundImage:[UIImage imageNamed:@"点选－已选日期－红"] forState:UIControlStateSelected];
        [_btn setBackgroundImage:[UIImage imageNamed:@"点选－不可选日期－灰"]forState:UIControlStateDisabled];
        [self addSubview:_btn];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _btn.frame = CGRectMake(3, 3, frame.size.width-6, frame.size.height-6);
    _btn.layer.cornerRadius = _btn.frame.size.width/2;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [_btn setTitle:title forState:state];
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [_btn addTarget:target action:action forControlEvents:controlEvents];
}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [_btn setTitleColor:color forState:state];
}

-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    [_btn setBackgroundImage:image forState:state];
}

-(void)setEnabled:(BOOL)enabled{
    [_btn setEnabled:enabled];
}

#pragma mark - 

-(void)setTag:(NSInteger)tag{
    [super setTag:tag];
    _btn.tag = tag;
}

@end
