//
//  Triangle.m
//  Shapes
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Triangle.h"
IB_DESIGNABLE
@implementation Triangle


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat padding = 50;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect)+padding, CGRectGetMaxY(rect)-padding);  // bottom left
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect)+padding);  // top middle
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-padding, CGRectGetMaxY(rect)-padding);  // bottom right
    CGContextClosePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextFillPath(ctx);
    
    [[UIColor redColor] set];
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect)+padding, CGRectGetMaxY(rect)-padding);  // bottom left
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect)+padding);  // top middle
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-padding, CGRectGetMaxY(rect)-padding);  // bottom right
    CGContextClosePath(ctx);
    
    CGContextSetLineWidth(ctx, 15);
    CGContextStrokePath(ctx);
    
}


@end
