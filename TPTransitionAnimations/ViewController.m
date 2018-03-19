//
//  ViewController.m
//  TPTransitionAnimations
//
//  Created by 唐鹏 on 2018/3/19.
//  Copyright © 2018年 ICX. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
#import "TPTransitionDelegate.h"
#import "TPTransitionController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property(strong,nonatomic) TPTransitionDelegate *tp_trasitionDelegate;
@property(strong,nonatomic) BViewController *b;

@property(assign,nonatomic) BOOL presented;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}


#pragma mark - delegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    TPTransitionController *presentation = [[TPTransitionController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    TPTransitionAnimation *anmation = [[TPTransitionAnimation alloc] initWithDurationTime:self.duration presented:YES];
//    anmation.presentBlock = self.presentBlock;
    self.presented = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    TPTransitionAnimation *anmation = [[TPTransitionAnimation alloc] initWithDurationTime:self.duration presented:NO];
//    anmation.dismissBlock = self.dismissBlock;
    
    self.presented = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.alpha = 0.01;
        toView.backgroundColor = [UIColor orangeColor];
        [UIView animateWithDuration:0.3 animations:^{
            toView.alpha = 1.0;
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:0.3 animations:^{
            fromView.alpha = 0.01;
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

#pragma mark - event

- (IBAction)begin:(id)sender {
//    [self.tp_trasitionDelegate beginPresenting];
    [self presentViewController:self.b animated:YES completion:nil];
}
- (BViewController *)b{
    if (!_b){
        _b = [[BViewController alloc] init];
        _b.transitioningDelegate = self;
        _b.modalPresentationStyle = UIModalPresentationCustom;
    }
    return _b;
}

- (TPTransitionDelegate *)tp_trasitionDelegate{
    if (!_tp_trasitionDelegate){
        _tp_trasitionDelegate = [[TPTransitionDelegate alloc] initWithPresentedController:self presentingController:self.b presentBlock:^(UIView *toView, id<UIViewControllerContextTransitioning> transitionContext) {
            toView.alpha = 0.01;
            toView.backgroundColor = [UIColor orangeColor];
            [UIView animateWithDuration:0.3 animations:^{
                toView.alpha = 1.0;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } dismissBlock:^(UIView *fromView, id<UIViewControllerContextTransitioning> transitionContext) {
            [UIView animateWithDuration:0.3 animations:^{
                fromView.alpha = 0.01;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }];
        _tp_trasitionDelegate.duration = 0.5;
    }
    return _tp_trasitionDelegate;
}

@end
