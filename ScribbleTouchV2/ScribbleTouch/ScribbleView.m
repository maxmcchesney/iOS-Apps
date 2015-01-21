//
//  ScribbleView.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/14/15.
//  Copyright (c) 2015 Michael McChesney. All rights reserved.
//

#import "ScribbleView.h"

@implementation ScribbleView

//    @[
//
//        @{
//            @"type":@"path",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"points":@[CGPoint,CGPoint,CGPoint]
//        },
//
//        @{
//            @"type":@"circle",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"frame":CGRect
//        }
//
//    ];



- (NSMutableArray *)scribbles {
    
    if (_scribbles == nil) { _scribbles = [@[] mutableCopy]; }
    return _scribbles;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (NSDictionary * scribble in self.scribbles) {
        
        NSArray * points = scribble[@"points"];
        
        //////// STOKE COLOR & WIDTH
        
        CGContextSetLineWidth(context, [scribble[@"strokeWidth"] floatValue]);
        
        float shapeAlpha = [scribble[@"shapeAlpha"] floatValue];
        
        UIColor * strokeColor = scribble[@"strokeColor"];
        [[strokeColor colorWithAlphaComponent:shapeAlpha] set];
//        [strokeColor set];
        
        //////// BUILD STOKE PATH
        
        BOOL typeIsScribble = [scribble[@"type"] isEqualToString:@"Scribble"];
        BOOL typeIsLine = [scribble[@"type"] isEqualToString:@"Line"];
        
        if (typeIsScribble || typeIsLine) {
/////   SCRIBBLE AND LINE STROKE
            
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            
            for (NSValue * pointValue in scribble[@"points"]) {
                
                CGPoint point = [pointValue CGPointValue];
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        
        if ([scribble[@"type"] isEqualToString:@"Rectangle"] && points.count > 1) {
/////   RECTANGLE STROKE
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);

            CGContextAddRect(context, rect);
            
        }
        
        if ([scribble[@"type"] isEqualToString:@"Triangle"] && points.count > 1) {
/////   TRIANGLE STROKE
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            CGContextAddLineToPoint(context, (secondPoint.x - firstPoint.x) * 2 + firstPoint.x, firstPoint.y);
            CGContextClosePath(context);

        }

        if ([scribble[@"type"] isEqualToString:@"Ellipse"] && points.count > 1) {
/////   ELLIPSE STROKE
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
            CGContextAddEllipseInRect(context, rect);
            
        }
        
        CGContextStrokePath(context);
        
        
        //////// FILL COLOR & WIDTH
        

    
        UIColor * fillColor = scribble[@"fillColor"];
        [[fillColor colorWithAlphaComponent:shapeAlpha] set];
        [fillColor set];
        
        //////// BUILD PATH
        

        
        if (typeIsScribble || typeIsLine) {
            /////   SCRIBBLE AND LINE FILL
            
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            
            for (NSValue * pointValue in scribble[@"points"]) {
                
                CGPoint point = [pointValue CGPointValue];
                CGContextAddLineToPoint(context, point.x, point.y);
            }
            CGContextFillPath(context);
        }
        
        if ([scribble[@"type"] isEqualToString:@"Rectangle"] && points.count > 1) {
            /////   RECTANGLE FILL
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
            CGContextFillRect(context, rect);
        }

        if ([scribble[@"type"] isEqualToString:@"Triangle"] && points.count > 1) {
            /////   TRIANGLE FILL
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            CGContextAddLineToPoint(context, (secondPoint.x - firstPoint.x) * 2 + firstPoint.x, firstPoint.y);
            CGContextClosePath(context);
            CGContextFillPath(context);
        }
        
        if ([scribble[@"type"] isEqualToString:@"Ellipse"] && points.count > 1) {
            /////   ELLIPSE FILL
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
            CGContextFillEllipseInRect(context, rect);
        }
        
        CGContextStrokePath(context);
        
    }
    
}

@end
