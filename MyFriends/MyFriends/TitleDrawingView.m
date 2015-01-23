//
//  TitleDrawingView.m
//  MyFriends
//
//  Created by Michael McChesney on 1/23/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "TitleDrawingView.h"
IB_DESIGNABLE
@implementation TitleDrawingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat frameHeight = self.frame.size.height;
    CGFloat frameWidth = self.frame.size.width;
    CGFloat padding = 15;
    
    CGContextSetLineWidth(context, 2.0);
    [[UIColor whiteColor] set];
    
    int multiplier = 1;
    
    while (multiplier < 12) {
        
        CGRect rectangle = CGRectMake(padding*multiplier, padding*multiplier, frameWidth - (padding*multiplier*2), frameHeight - (padding*multiplier*2));
        CGContextAddEllipseInRect(context, rectangle);
        
        multiplier++;
    }
    
    CGContextSetShadowWithColor(context, CGSizeMake(-3, 4), 1, [UIColor colorWithRed:0.424f green:0.639f blue:0.498f alpha:1.0f].CGColor);
    
    CGContextStrokePath(context);

}


@end
