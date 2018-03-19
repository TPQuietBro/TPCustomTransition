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
    //添加收手势
}

- (void)dismissalTransitionWillBegin{}


- (void)dismissalTransitionDidEnd:(BOOL)completed{
    [self.presentedView removeFromSuperview];
}

- (void)containerViewWillLayoutSubviews{
    self.presentedView.frame = self.containerView.bounds;
}
@end
