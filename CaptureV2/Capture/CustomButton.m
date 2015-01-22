//
//  CustomButton.m
//  Capture
//
//  Created by Michael McChesney on 1/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    self.layer.cornerRadius = self.cornerSize;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = [self.borderColor CGColor];
    self.layer.masksToBounds = YES;

}


@end
