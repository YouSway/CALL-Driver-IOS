//
//  CustomView.m
//  DriverClient
//
//  Created by YouSway on 2016/7/2.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 2);
    CGContextSetAllowsAntialiasing(context, true);
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapButt);
    //设置画笔颜色：黑色
    CGContextSetRGBStrokeColor(context, 220.0 / 255.0, 220.0 / 255.0, 220.0 / 255.0, 1.0);
    CGContextBeginPath(context);
    for(int i=1;i<=4;i++){
        CGContextMoveToPoint(context, width*0.05, (height*0.4/5)*i);
        CGContextAddLineToPoint(context, width*0.75, (height*0.4/5)*i);
    }
    
    CGContextStrokePath(context);
    
    
}


@end