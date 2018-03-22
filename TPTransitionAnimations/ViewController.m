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
#import "Masonry.h"
@interface ViewController ()
@property(strong,nonatomic) TPTransitionDelegate *tp_trasitionDelegate;

@property(strong,nonatomic) BViewController *b;

@property(assign,nonatomic) BOOL presented;

@property(strong,nonatomic) UIImage *image;

@property(assign,nonatomic) CGRect originalFrame;

@property(strong,nonatomic) UIImageView *cpImageView;

@property(strong,nonatomic) UIColor *originalColor;

@property(strong,nonatomic) UIScrollView *containerView;
@property(strong,nonatomic) UIView *contentView;

@property(strong,nonatomic) UILabel *testLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image = [UIImage imageNamed:@"fengjing"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(begin:)];
    [self.imageView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    longPress.minimumPressDuration = 0.1;
    [self.imageView addGestureRecognizer:longPress];
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

- (UIScrollView *)containerView{
    if (!_containerView){
        _containerView = [[UIScrollView alloc] init];
    }
    return _containerView;
}
- (UIView *)contentView{
    if (!_contentView){
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}

- (UIImageView *)cpImageView{
    if (!_cpImageView){
        _cpImageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    }
    return _cpImageView;
}

- (UILabel *)testLabel{
    if (!_testLabel){
        _testLabel = [[UILabel alloc] init];
        _testLabel.text = @"遇到一个需求，就是要求让一个ImageView有一个从屏幕上边缘滑入屏幕中间的动画效果，子view的父控件在屏幕中间，要有从屏幕边缘滑入的效果，则必定要求子view的动画不能限制在其父控件的布局之内，但是android的补间动画（Tween Animation）做不到这个效果，补间动画只能让子view在其父控件内实现动画，而强大的属性动画可以突破父控件布局的限制（这个观点后面测试了，是错误的，也就是说属性动画也不能让子view突破父控件的区域，这里道个歉，想让子view不受约束，可能需要将子view放到更上层的布局里面去，感谢同学的指正．属性动画的优势在于view移动到哪，touch事件就是在哪触发，而补间动画则是表面上移动了view，实际上view的touch事件还是只能在原来最初的位置触发），但是android 的属性动画（Property Animation）是在3.0之后才引入的，在android2.3的系统版本里面无法使用这么强大的动画效果，这就有点捉鸡了。在看到别人分析的桌面浮窗（类似某卫士的桌面浮窗控件，点击后可以杀死后台任务）实现原理后，找到了灵感，决定采用浮窗绘制出滑入的动画。实现方案就是，先让ImageView在父控件内设置为View.INVISIBLE即不可见的效果，另写一个布局文件，内容就是该ImageView，算是个克隆体吧，之后需要使用这个克隆体来实现动画效果。当绘制的克隆体从屏幕上沿滑入，下滑到预定的位置，就gone掉这个克隆体，让原来的ImageView显示出来即可。当然，为了保证动画效果，还需要确保滑入的体位正确╮(╯▽╰)╭，所以还需要计算出克隆体初始的位置.";
        _testLabel.font = [UIFont systemFontOfSize:15];
        _testLabel.numberOfLines = 0;
        
        CGFloat height = [_testLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0) options:kNilOptions attributes:@{NSFontAttributeName : self.testLabel.font} context:nil].size.height + 5;
        
        _testLabel.frame = CGRectMake(0, 20, SCREEN_WIDTH - 20, height);
        [_testLabel sizeToFit];
    }
    return _testLabel;
}

- (TPTransitionDelegate *)tp_trasitionDelegate{
    if (!_tp_trasitionDelegate){
        _tp_trasitionDelegate = [[TPTransitionDelegate alloc] initWithPresentedController:self presentingController:self.b presentBlock:^(UIView *toView, id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration) {
            //设置初始frame
            self.containerView.frame = self.originalFrame;
            self.contentView.frame = self.containerView.bounds;
            self.cpImageView.frame = self.containerView.bounds;
            
            toView.backgroundColor = self.originalColor;

            //添加内容view
            [self.containerView addSubview:self.contentView];
            //添加图片
            [self.containerView addSubview:self.cpImageView];
  
            [toView addSubview:self.containerView];
            
            [UIView animateWithDuration:duration animations:^{
                [self setContainerFrame:self.containerView];
                [self setContentFrame:self.contentView];
                [self setFrame:self.cpImageView];
            }completion:^(BOOL finished) {
                
//                [UIView animateWithDuration:0.2 animations:^{
//                    self.containerView.y = 0;
//                }completion:^(BOOL finished) {
//
//                }];
                
                toView.userInteractionEnabled = NO;
                [self requestWithBlock:^(id responseData) {
                    self.containerView.contentSize = CGSizeMake(0, 2 * SCREEN_HEIGHT);
                    self.contentView.height = 2 * SCREEN_HEIGHT;
                    toView.userInteractionEnabled = YES;
                    
                    [self.contentView addSubview:self.testLabel];
                }];
                [transitionContext completeTransition:YES];
            }];
        } dismissBlock:^(UIView *fromView, id<UIViewControllerContextTransitioning> transitionContext,NSTimeInterval duration) {
            fromView.backgroundColor = [UIColor clearColor];
            [UIView animateWithDuration:duration animations:^{
                [self resetView:self.containerView];
                [self resetSubviews:self.contentView superView:self.contentView];
                [self resetSubviews:self.cpImageView superView:self.contentView];
            }completion:^(BOOL finished) {
                [self removeSubView];
                [transitionContext completeTransition:YES];
            }];
        }];
        _tp_trasitionDelegate.duration = 0.3;
    }
    return _tp_trasitionDelegate;
}
#pragma mark - private
- (void)scale:(UILongPressGestureRecognizer *)longPress{
    UIView *view = longPress.view;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
    }else if (longPress.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {
            [self.tp_trasitionDelegate beginPresenting];
        }];
    }
    
}
- (void)requestWithBlock:(void(^)(id responseData))block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"请求成功");
        block ? block(@"success") : nil;
    });
}

- (void)setContainerFrame:(UIScrollView *)container{
    container.x = 0;
    container.y = 0;
    container.width = SCREEN_WIDTH;
    container.height = SCREEN_HEIGHT;
}
- (void)setContentFrame:(UIView *)content{
    content.x = 10;
    content.y = SCREEN_HEIGHT - 300;
    content.width = SCREEN_WIDTH - 20;
    content.height = SCREEN_HEIGHT + 20;
}
- (void)setFrame:(UIView *)view{
    view.x = 0;
    view.y = 0;
    view.width = SCREEN_WIDTH;
    view.height = SCREEN_HEIGHT - 300;
}
- (void)resetView:(UIView *)view{
    view.x = self.originalFrame.origin.x;
    view.y = self.originalFrame.origin.y;
    view.width = self.originalFrame.size.width;
    view.height = self.originalFrame.size.height;
}
- (void)resetSubviews:(UIView *)subView superView:(UIView *)superView{
    subView.x = 0;
    subView.y = 0;
    subView.width = self.originalFrame.size.width;
    subView.height = self.originalFrame.size.height;
}
- (void)removeSubView{
    [self.containerView removeFromSuperview];
    [self.contentView removeFromSuperview];
    [self.cpImageView removeFromSuperview];
}
@end
