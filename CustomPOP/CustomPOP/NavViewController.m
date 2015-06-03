//
//  NavViewController.m
//  CustomPOP
//
//  Created by 韩小东 on 15/4/7.
//  Copyright (c) 2015年 Wuhan Maxtop Electronics Technology Co., Ltd. All rights reserved.
//

#import "NavViewController.h"
#import "PopAnimation.h"
#import <objc/runtime.h>

@interface NavViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,retain)UIPercentDrivenInteractiveTransition *interactivePopTransition;
@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    /**
     *  获取系统原始手势的view，并把原始手势关闭
     */
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取它的方法签名为handleNavigationTransition
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:navigationInteractiveTransition action:handleTransition];
    popRecognizer.delegate = self;
    [gestureView addGestureRecognizer:popRecognizer];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
//    [self.view addGestureRecognizer:pan];
//    unsigned int count = 0;
//    Ivar *var = class_copyIvarList([UIGestureRecognizer class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar  _var = *(var + i);
//        NSLog(@"%s",ivar_getTypeEncoding(_var));
//        NSLog(@"%s",ivar_getName(_var));
//    }
//    NSMutableArray *_targets = [self.interactivePopGestureRecognizer valueForKey:@"_targets"];
//    NSLog(@"%@",_targets);
//    NSLog(@"%@",_targets[0]);
    
}

/**
 *  我们把用户每次pan手势操作作为一次pop动画执行
 */
//- (void)panEvent:(UIPanGestureRecognizer *)pan {
//    /**
//     *  interactivePopTransition就是我们说的方法2返回的对象，我们需要更新它的进度来控制动画的流程，我们用手指在视图中的位置与视图宽度比例作为它的进度。
//     */
//    CGFloat progress = [pan translationInView:self.view].x / self.view.bounds.size.width;
//    /**
//     *  稳定进度区间，让它在0.0~1.0之间
//     */
//    progress = MIN(1.0, MAX(0.0, progress));
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        /**
//         *  手势开始，新建一个监控对象
//         */
//        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
//        /**
//         *  告诉控制器开始执行pop动画
//         */
//        [self popViewControllerAnimated:YES];
//    }else if (pan.state == UIGestureRecognizerStateChanged){
//        /**
//         *  更新手势的完成进度
//         */
//        [self.interactivePopTransition updateInteractiveTransition:progress];
//    }else if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled){
//        /**
//         *  手势结束时如果进度大于一半，那么就完成pop，否则重新来过
//         */
//        if (progress>0.5) {
//            [self.interactivePopTransition finishInteractiveTransition];
//        }else{
//            [self.interactivePopTransition cancelInteractiveTransition];
//        }
//        self.interactivePopTransition = nil;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                  animationControllerForOperation:(UINavigationControllerOperation)operation
//                                               fromViewController:(UIViewController *)fromVC
//                                                 toViewController:(UIViewController *)toVC{
//    /**
//     *  判断如果当前执行的是pop操作，则返回我们自定义的pop动画对象
//     */
//    if (operation == UINavigationControllerOperationPop) {
//        return [[PopAnimation alloc] init];
//    }
//    return nil;
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
//    /**
//     *  传给你当前的动画对象animationController，判断如果是我们自定义的pop动画，那么就返回interactivePopTransition来监控动画完成进度。
//     */
//    if ([animationController isKindOfClass:[PopAnimation class]]) {
//        return self.interactivePopTransition;
//    }else
//        return nil;
//}

#pragma mark -
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
