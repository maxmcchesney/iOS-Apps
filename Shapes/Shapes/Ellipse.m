//
//  Ellipse.m
//  Shapes
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Ellipse.h"
#import "ViewController.h"
IB_DESIGNABLE

@implementation Ellipse


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    //    JO'S WAY OF DOING ELLIPSE
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.fillColor set];
//    CGContextFillEllipseInRect(ctx, rect);     SHORT WAY HERE. LONG/CUSTOM WAY BELOW.
    //CP = control point
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    CGFloat xCP = w / 4;
    CGFloat yCP = h / 4;
    
    CGContextMoveToPoint(ctx, w / 2, 0);
    
    CGContextAddCurveToPoint(ctx, w - xCP, 0, w, yCP, w, h / 2);
    CGContextAddCurveToPoint(ctx, w, h - yCP, w - xCP, h, w / 2, h);
    CGContextAddCurveToPoint(ctx, xCP, h, 0, h - yCP, 0, h / 2);
    CGContextAddCurveToPoint(ctx, 0, yCP, xCP, 0, w / 2, 0);

    CGContextFillPath(ctx);
    
//    CGContextSetShadowWithColor(ctx, CGSizeMake(-3, 5), 3, [UIColor blackColor].CGColor);
//    CGContextStrokePath(ctx);

    
    //  MY WAY WITH WHILE LOOP
    CGFloat frameHeight = self.frame.size.height;
    CGFloat frameWidth = self.frame.size.width;
    CGFloat padding = 25;
    
    NSLog(@"%f x %f", frameWidth, frameHeight);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor redColor].CGColor);
    
    int multiplier = 1;
    
    while (multiplier < 10) {
            
        CGRect rectangle = CGRectMake(padding*multiplier, padding*multiplier, frameWidth - (padding*multiplier*2), frameHeight - (padding*multiplier*2));
        CGContextAddEllipseInRect(context, rectangle);
            
        multiplier++;
    }
    
    CGContextSetShadowWithColor(context, CGSizeMake(-3, 5), 3, [UIColor whiteColor].CGColor);
    
    CGContextStrokePath(context);

//    CGContextRelease(context);    NOT SURE ABOUT THIS LINE, LEAVE COMMENTED OUT
    
    

    
}


@end
