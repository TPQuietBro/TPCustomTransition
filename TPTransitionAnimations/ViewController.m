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

@property(strong,nonatomic) UIImageView *cpImageView;

@property(strong,nonatomic) UIColor *originalColor;
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
    [self.tp_trasitionDelegate beginPresenting];
}
- (BViewController *)b{
    if (!_b){
        _b = [[BViewController alloc] init];
        _b.image = self.image;
        _b.originalFrame = self.originalFrame;
        self.originalColor = _b.view.backgroundColor;
    }
    return _b;
}

- (TPTransitionDelegate *)tp_trasitionDelegate{
    if (!_tp_trasitionDelegate){
        _tp_trasitionDelegate = [[TPTransitionDelegate alloc] initWithPresentedController:self presentingController:self.b presentBlock:^(UIView *toView, id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration) {
            self.cpImageView = [[UIImageView alloc] initWithImage:self.imageView.image];
            self.cpImageView.frame = self.originalFrame;
            toView.backgroundColor = self.originalColor;
            [toView addSubview:self.cpImageView];
            [UIView animateWithDuration:0.5 animations:^{
                self.cpImageView.x = 0;
                self.cpImageView.y = 0;
                self.cpImageView.width = SCREEN_WIDTH;
                self.cpImageView.height = SCREEN_HEIGHT;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } dismissBlock:^(UIView *fromView, id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration) {
            fromView.backgroundColor = [UIColor clearColor];
            [UIView animateWithDuration:0.5 animations:^{
                self.cpImageView.x = self.originalFrame.origin.x;
                self.cpImageView.y = self.originalFrame.origin.y;
                self.cpImageView.width = self.originalFrame.size.width;
                self.cpImageView.height = self.originalFrame.size.height;
            }completion:^(BOOL finished) {
                [self.cpImageView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        }];
        _tp_trasitionDelegate.duration = 0.5;
    }
    return _tp_trasitionDelegate;
}

@end
