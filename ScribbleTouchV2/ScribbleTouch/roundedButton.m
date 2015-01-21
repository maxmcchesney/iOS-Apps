//
//  roundedButton.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/16/15.
//  Copyright (c) 2015 Michael McChesney. All rights reserved.
//

#import "roundedButton.h"
#import <QuartzCore/QuartzCore.h>
IB_DESIGNABLE

@implementation roundedButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    // Adds IBInspectable properties for custom buttons on Storyboard: borders, rounded corners.
    self.layer.cornerRadius = self.cornerSize;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    
}


@end
