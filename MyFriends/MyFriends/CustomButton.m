//
//  CustomButton.m
//  MyFriends
//
//  Created by Michael McChesney on 1/23/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "CustomButton.h"
IB_DESIGNABLE
@implementation CustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerSize;
    self.layer.masksToBounds = YES;
    
}


@end
