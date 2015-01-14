//
//  ScribbleView.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/14/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ScribbleView.h"

@implementation ScribbleView
// To lay out how we're going to think about this...
//@[
//
//    @{
//        @"type",@"path",
//        @"fillColor":[UIColor greenColor],
//        @"strokeColor":[UIColor blackColor],
//        @"strokeWidth":@2,
//        @"points":@[CGPoint, CGPoint, CGPoint]
//    },
//
//    @{
//        @"type",@"circle",
//        @"fillColor":[UIColor greenColor],
//        @"strokeColor":[UIColor blackColor],
//        @"strokeWidth":@2,
//        @"frame":CGRect
//    }
//
//];

- (NSMutableArray *)scribbles {
    // This overrides the getter method to ensure it's always a mutable array and never nill.
    if (_scribbles == nil) { _scribbles = [@[] mutableCopy]; }
    return _scribbles;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSDictionary *scribble in self.scribbles) {

        CGContextSetLineWidth(context, [scribble[@"strokeWidth"] floatValue]);
        
        UIColor *strokeColor = scribble[@"strokeColor"];
        [strokeColor set];
        
        CGPoint firstPoint = [scribble[@"points"][0] CGPointValue]; // could also have done allObjects firstObject instead of [0].
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        
        for (NSValue * pointValue in scribble[@"points"]) {
        
            CGPoint point = [pointValue CGPointValue];

            CGContextAddLineToPoint(context, point.x, point.y);
            
        }
        
        CGContextStrokePath(context);
        
    }
    
}







@end
