//
//  TPTransitionAnimation.m
//  TPTransitionAnimations
//
//  Created by tangpeng on 2018/3/19.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "TPTransitionAnimation.h"
@interface TPTransitionAnimation()
@property(assign,nonatomic) BOOL presented;
@property(assign,nonatomic) NSTimeInterval duration;
@end
@implementation TPTransitionAnimation

- (instancetype)initWithDurationTime:(NSTimeInterval)duration presented:(BOOL)presented{
    self = [super init];
    if (self) {
        self.presented = presented;
        self.duration = duration;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        self.presentBlock ? self.presentBlock(toView, transitionContext,[self transitionDuration:transitionContext]) : nil;
    }else{
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        self.dismissBlock ? self.dismissBlock(fromView, transitionContext,[self transitionDuration:transitionContext]) : nil;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration ? self.duration : 1.0;
}
@end
