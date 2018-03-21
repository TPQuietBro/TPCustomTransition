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
#import "TPFrame.h"

@interface ViewController ()
@property(strong,nonatomic) TPTransitionDelegate *tp_trasitionDelegate;

@property(strong,nonatomic) BViewController *b;

@property(assign,nonatomic) BOOL presented;

@property(strong,nonatomic) UIImage *image;

@property(assign,nonatomic) CGRect originalFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image = [UIImage imageNamed:@"fengjing"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(begin:)];
    [self.imageView addGestureRecognizer:tap];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.originalFrame = self.imageView.frame;
}
#pragma mark - event

- (IBAction)begin:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.x = 0;
        self.imageView.y = 0;
        self.imageView.width = SCREEN_WIDTH;
        self.imageView.height = SCREEN_HEIGHT;
    }completion:^(BOOL finished) {
        self.imageView.frame = self.originalFrame;
        [self.tp_trasitionDelegate beginPresenting];
    }];
    
}
- (BViewController *)b{
    if (!_b){
        _b = [[BViewController alloc] init];
        _b.image = self.image;
        _b.originalFrame = self.originalFrame;
    }
    return _b;
}

- (TPTransitionDelegate *)tp_trasitionDelegate{
    if (!_tp_trasitionDelegate){
        _tp_trasitionDelegate = [[TPTransitionDelegate alloc] initWithPresentedController:self presentingController:self.b presentBlock:^(UIView *toView, id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration) {
            [transitionContext completeTransition:YES];
        } dismissBlock:^(UIView *fromView, id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration) {
            [transitionContext completeTransition:YES];
        }];
        _tp_trasitionDelegate.duration = 0.5;
    }
    return _tp_trasitionDelegate;
}

@end
