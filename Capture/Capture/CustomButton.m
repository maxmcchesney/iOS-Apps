//
//  CustomButton.m
//  Capture
//
//  Created by Michael McChesney on 1/20/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "CustomButton.h"
IB_DESIGNABLE

@implementation CustomButton


- (void)drawRect:(CGRect)rect {

    self.layer.cornerRadius = self.cornerSize;
    self.layer.masksToBounds = YES;

    self.layer.borderColor = [self.borderColor CGColor];
    self.layer.borderWidth = self.borderWidth;
    
}


@end
