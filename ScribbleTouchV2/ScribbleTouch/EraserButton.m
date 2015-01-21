//
//  EraserButton.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/16/15.
//  Copyright (c) 2015 Michael McChesney. All rights reserved.
//

#import "EraserButton.h"
//#import <QuartzCore/QuartzCore.h>
//IB_DESIGNABLE
@implementation EraserButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    float width = rect.size.width;
    float height = rect.size.height;
    
    self.layer.cornerRadius = height / 2;
    self.layer.masksToBounds = YES;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // Circle
    [[UIColor redColor] set];
    CGRectMake(0, 0, width, height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetLineWidth(ctx, 10);
    CGContextStrokePath(ctx);
    // Line through middle
    CGContextMoveToPoint(ctx, width/4, height/4);
    CGContextAddLineToPoint(ctx, width/4*3, height/4*3);
    CGContextSetLineWidth(ctx, 6);
    CGContextStrokePath(ctx);
}


@end
