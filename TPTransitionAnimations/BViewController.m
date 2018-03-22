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
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self dismissViewControllerAnimated:YES completion:nil];
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
