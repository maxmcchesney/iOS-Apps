//
//  SlickSlider.m
//  Capture
//
//  Created by Michael McChesney on 1/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "SlickSlider.h"
IB_DESIGNABLE

@implementation SlickSlider
{
    float sliderPosition;
}

// HOOK UP START POSITION IN STORYBOARD
- (void)setStartPosition:(CGFloat)startPosition {
    sliderPosition = startPosition * self.frame.size.width;
    [self setNeedsDisplay];
    _startPosition = startPosition;
}

// OVERRIDE SLIDERCOLOR TO MAKE DEFAULT COLOR WHITE
- (UIColor *)sliderColor {
    if (_sliderColor == nil) _sliderColor = [UIColor whiteColor];
    return _sliderColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.sliderColor set];
    
    CGContextSetLineWidth(ctx, 1);
    
    CGRect insetRect = CGRectInset(rect, 5, 5);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:rect.size.height / 2];
    
    CGContextAddPath(ctx, path.CGPath);
    
    // IMPLEMENT REVERSE COLOR OPTION FOR SLIDER
    if (self.reverseColor) {
        CGContextFillPath(ctx);
    } else {
        CGContextStrokePath(ctx);
    }
    
    CGRect circleRect = CGRectInset(insetRect, 4, 4);
    circleRect.size.width = circleRect.size.height;

    float minX = circleRect.origin.x;
    float maxX = rect.size.width - minX - circleRect.size.width;
    
    
    sliderPosition -= circleRect.size.width / 2;
    
    
    if (sliderPosition > maxX) sliderPosition = maxX;
    if (sliderPosition < minX) sliderPosition = minX;
    
    circleRect.origin.x = sliderPosition;
    
    float value = (sliderPosition - minX) / (maxX-minX);

    [self.delegate sliderDidFinishUpdatingWithValue:value];
    
    // OTHER PART OF REVERSE COLOR FEATURE FOR SLIDER
    if (self.reverseColor) {
        
//        CGContextSetBlendMode(ctx, kCGBlendModeClear);
        [self.backgroundColor set];
    }
    CGContextFillEllipseInRect(ctx, circleRect);
}

// LISTEN FOR TOUCHES AND PASS THEM TO ONE METHOD BELOW (UPDATESLIDER)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updateSliderWithTouches:touches];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updateSliderWithTouches:touches];
}
// UPDATE SLIDER
-(void)updateSliderWithTouches:(NSSet *)touches {
    
    UITouch * touch = [[touches allObjects] firstObject];
    
    CGPoint location = [touch locationInView:self];
    
    sliderPosition = location.x;
    
    [self setNeedsDisplay];
    
}


@end
