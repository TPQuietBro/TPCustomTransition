//
//  TPTransitionDelegate.m
//  TPTransitionAnimations
//
//  Created by tangpeng on 2018/3/19.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "TPTransitionDelegate.h"
#import "TPTransitionController.h"
#import "TPTransitionAnimation.h"
@interface TPTransitionDelegate()
@property(strong,nonatomic) UIViewController *presentedVc;
@property(strong,nonatomic) UIViewController *presentingVc;
@end
@implementation TPTransitionDelegate

- (instancetype)initWithPresentedController:(UIViewController *)presentedController presentingController:(UIViewController *)presentingController presentBlock:(presentAnimation)presentBlock dismissBlock:(dismissAnimation)dismissBlock{
    if (self = [super init]) {
        self.presentedVc = presentedController;
        self.presentingVc = presentingController;
        self.presentBlock = [presentBlock copy];
        self.dismissBlock = [dismissBlock copy];
        
        self.presentingVc.transitioningDelegate = self;
        self.presentingVc.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    TPTransitionController *presentation = [[TPTransitionController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    TPTransitionAnimation *anmation = [[TPTransitionAnimation alloc] initWithDurationTime:self.duration presented:YES];
    anmation.presentBlock = self.presentBlock;
    return anmation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    TPTransitionAnimation *anmation = [[TPTransitionAnimation alloc] initWithDurationTime:self.duration presented:NO];
    anmation.dismissBlock = self.dismissBlock;
    return anmation;
}

- (void)beginPresenting{
    [self.presentedVc presentViewController:self.presentingVc animated:YES completion:nil];
}
@end
