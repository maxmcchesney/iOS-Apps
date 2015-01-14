//
//  Ellipse.m
//  Shapes
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Ellipse.h"
#import "ViewController.h"

@implementation Ellipse


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

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
    
    CGContextSetShadowWithColor(context, CGSizeMake(-3, 5), 3, [UIColor blackColor].CGColor);
    
    CGContextStrokePath(context);

//    CGContextRelease(context);

}


@end
