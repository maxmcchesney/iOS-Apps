//
//  Mouth.m
//  Human
//
//  Created by Michael McChesney on 1/6/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Mouth.h"
#import "GoldTooth.h"

@implementation Mouth

- (BOOL)chewFood:(int)foodSize {
    
    BOOL chew = false;
    
    NSLog(@"%d",foodSize);
    
    if (foodSize < 20) {
        chew = true;
    }
    
    return chew;
}

@end
