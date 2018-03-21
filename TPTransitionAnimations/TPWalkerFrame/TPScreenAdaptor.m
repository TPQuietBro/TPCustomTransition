//
//  TPScreenAdaptor.m
//  KYTipAlertView
//
//  Created by 唐鹏 on 2017/7/6.
//  Copyright © 2017年 唐鹏. All rights reserved.
//

#import "TPScreenAdaptor.h"

@implementation TPScreenAdaptor
+ (CGFloat)pxWidthWithNumber:(CGFloat)number{
    
    CGFloat width = 0;
    if (IS_IPHONE_5_ || IS_IPHONE_4_OR_LESS) {
        //iphone4/5有些特殊,需要像素点的1/2.5倍才会比较合适
        width = number / 2.5;
    }else if (IS_IPHONE_6){
        width = SCREEN_WIDTH / IPHONE_6_WIDTH_PX * number;
    }else if (IS_IPHONE_6P){
        width = SCREEN_WIDTH / IPHONE_6_WIDTH_PX * number;
    }else if (IS_IPHONE_X) {
        width = SCREEN_WIDTH / IPHONE_6_WIDTH_PX * number;
    }
    return width;
}
+ (CGFloat)pxHeightWithNumber:(CGFloat)number{
    
    CGFloat height = 0;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5_) {
        height = number / 2.5;
    }else if (IS_IPHONE_6){
        height = SCREEN_WIDTH / IPHONE_6_WIDTH_PX * number;
    }else if (IS_IPHONE_6P){
        height = SCREEN_WIDTH / IPHONE_6_WIDTH_PX * number;
    }else if (IS_IPHONE_X) {
        height = SCREEN_WIDTH / IPHONE_6_WIDTH_PX * number;
    }
    return height;
}
@end
