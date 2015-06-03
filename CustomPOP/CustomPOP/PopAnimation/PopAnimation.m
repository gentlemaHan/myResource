//
//  PopAnimation.m
//  CustomPOP
//
//  Created by 韩小东 on 15/4/7.
//  Copyright (c) 2015年 Wuhan Maxtop Electronics Technology Co., Ltd. All rights reserved.
//

#import "PopAnimation.h"

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    //返回动画执行的时间
    return 0.25;
}

/**
 *  transitionContext你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //一下两个控制器分别为即将消失的控制器和即将显示的控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //转场动画是两个视图控制器之间的动画，需要一个container来作为一个舞台，让动画执行
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //执行动画，我们让fromVC的视图移到屏幕最右侧
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
                     }completion:^(BOOL finish){
                         //当你的动画完成，这个方法必须调用，否则系统会认为你的其余任何操作都在动画执行过程中
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

@end
