//
//  BViewController.m
//  TPTransitionAnimations
//
//  Created by tangpeng on 2018/3/19.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "BViewController.h"
#import "TPFrame.h"
@interface BViewController ()

@end

@implementation BViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    [self setSubviewsLayout];
}
#pragma mark - init methods

- (void)initSubviews{
    self.view.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [UIImageView new];
    imageView.userInteractionEnabled = YES;
    imageView.image = self.image;
    imageView.frame = self.view.bounds;
    self.imageView = imageView;
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.x = self.originalFrame.origin.x;
        self.imageView.y = self.originalFrame.origin.y;
        self.imageView.width = self.originalFrame.size.width;
        self.imageView.height = self.originalFrame.size.height;
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.imageView.frame = self.view.bounds;
    }];
}

- (void)setSubviewsLayout{
    
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter


@end
