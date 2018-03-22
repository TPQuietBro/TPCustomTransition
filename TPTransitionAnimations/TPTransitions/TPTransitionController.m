//
//  TPTransitionController.m
//  TPTransitionAnimations
//
//  Created by tangpeng on 2018/3/19.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "TPTransitionController.h"

@implementation TPTransitionController
- (void)presentationTransitionWillBegin{
    [self.containerView addSubview:self.presentedView];
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimissVc)];
    [self.containerView addGestureRecognizer:tap];
}
- (void)dimissVc{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)dismissalTransitionWillBegin{}


- (void)dismissalTransitionDidEnd:(BOOL)completed{
    [self.presentedView removeFromSuperview];
}

- (void)containerViewWillLayoutSubviews{
    self.presentedView.frame = self.containerView.bounds;
}
@end
