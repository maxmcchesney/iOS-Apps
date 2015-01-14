//
//  Robot.m
//  Speaking
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Robot.h"

@implementation Robot
//{
//    int powerLevel;
//}

-(void)cleanHouse {
    
    //Find out from the delegate how many rooms need to be cleaned
    int rooms = [self.delegate howManyRoomsDoIHaveToClean];
 
    NSLog(@"Robot starts cleaning %d rooms", rooms);
}

-(void)dance {
    
    NSString *danceStyle = [self.delegate whatTypeOfDance];
    
    NSLog(@"Robot dance style is: %@", danceStyle);
    
}

- (void)checkPower {
    
}

@end
