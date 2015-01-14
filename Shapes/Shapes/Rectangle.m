//
//  Rectangle.m
//  Shapes
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Rectangle.h"
IB_DESIGNABLE
@implementation Rectangle



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//Rectangle
    CGFloat padding = 50;
    
    [[UIColor brownColor] set];

    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect)+padding, CGRectGetMinY(rect)+padding);  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-padding, CGRectGetMinY(rect)+padding);  // top right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-padding, CGRectGetMaxY(rect)-padding);  // bottom right
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect)+padding, CGRectGetMaxY(rect)-padding);  // bottom left
    CGContextClosePath(ctx);
    
//    For x and y above, could have used rect.size.width and rect.size.height
//    CGContextSetFillColorWithColor(ctx, [UIColor brownColor].CGColor);     Slow way
    CGContextFillPath(ctx);
    
//    Stoke border
    [[UIColor blackColor] set];
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect)+padding, CGRectGetMinY(rect)+padding);  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-padding, CGRectGetMinY(rect)+padding);  // top right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-padding, CGRectGetMaxY(rect)-padding);  // bottom right
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect)+padding, CGRectGetMaxY(rect)-padding);  // bottom left
    CGContextClosePath(ctx);
    
    CGContextSetLineWidth(ctx, 15);
    CGContextStrokePath(ctx);
    
    
    
//    Easy way to fill a rectangle
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextFillRect(ctx, rect);
//    [[UIColor brownColor] set];
//    CGContextFillRect(ctx, rect);
    


}


@end
