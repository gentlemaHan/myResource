//
//  ViewController.m
//  UseCAEmitterLayer
//
//  Created by 韩小东 on 15/10/14.
//  Copyright © 2015年 HXD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.borderWidth = 1.f;
    emitterLayer.frame = CGRectMake(100, 100, 100, 100);
    //发射点
    emitterLayer.emitterPosition = CGPointMake(0, 0);
    //发射模式
    emitterLayer.emitterMode = kCAEmitterLayerSurface;
    //发射形状
    emitterLayer.emitterShape = kCAEmitterLayerSphere;
    [self.view.layer addSublayer:emitterLayer];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    //粒子产生率
    cell.birthRate = 5.f;
    //粒子生命周期
    cell.lifetime = 100.f;
    //速度值
    cell.velocity = 10;
    //速度值的微调整
    cell.velocityRange = 3.f;
    //y轴加速度
    cell.yAcceleration = 2.f;
    //发射的角度
    cell.emissionRange = 0.8*M_1_PI;
    //设置图片
    cell.contents = (__bridge id)([UIImage imageNamed:@"xuehua.png"].CGImage);
    //让CAEmitterCell与CAEmitterLayer产生关联
    emitterLayer.emitterCells = @[cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
