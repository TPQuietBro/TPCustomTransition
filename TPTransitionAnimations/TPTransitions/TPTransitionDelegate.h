//
//  TPTransitionDelegate.h
//  TPTransitionAnimations
//
//  Created by tangpeng on 2018/3/19.
//Copyright © 2018年 ICX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^presentAnimation)(UIView *toView,id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration);
typedef void(^dismissAnimation)(UIView *fromView,id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration);

@interface TPTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property(assign,nonatomic) NSTimeInterval duration;
@property(strong,nonatomic) presentAnimation presentBlock;
@property(strong,nonatomic) dismissAnimation dismissBlock;

- (instancetype)initWithPresentedController:(UIViewController *)presentedController presentingController:(UIViewController *)presentingController presentBlock:(presentAnimation)presentBlock dismissBlock:(dismissAnimation)dismissBlock;

- (void)beginPresenting;
@end
