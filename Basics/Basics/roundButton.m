//
//  roundButton.m
//  Basics
//
//  Created by Michael McChesney on 1/5/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "roundButton.h"

IB_DESIGNABLE

@implementation roundButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    // Drawing code

    self.layer.cornerRadius = self.cornerSize;
    self.layer.masksToBounds = YES;

}


@end
