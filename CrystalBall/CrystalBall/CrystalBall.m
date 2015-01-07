//
//  CrystalBall.m
//  CrystalBall
//
//  Created by Michael McChesney on 12/30/14.
//  Copyright (c) 2014 DigitalCrafts. All rights reserved.
//

#import "CrystalBall.h"

@implementation CrystalBall

- (NSArray *) predictions {
    if (_predictions == nil) {
        _predictions = [[NSArray alloc] initWithObjects:
                        @"1 Second",
                        @"5 Seconds",
                        @"PASS!",
                        @"Finish the goblet!",
                        @"4 Seconds",
                        nil];
    }
    return _predictions;
}


- (NSString*) randomPrediction {
    int random = arc4random_uniform(self.predictions.count);
    return [self.predictions objectAtIndex:random];
}

@end
