//
//  Finger.m
//  Human
//
//  Created by Michael McChesney on 1/6/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "Finger.h"

@implementation Finger


//The below 3 things are what gets created when you @property something.

@synthesize fingerPrint = _fingerPrint;

//getter NSString * fingerPrint = finger.fingerPrint;
- (NSString *)fingerPrint {
    
    return _fingerPrint;
    
}

//setter finger.fingerPrint = @"fingerprint";
- (void)setFingerPrint:(NSString *)fingerPrint {
    
    _fingerPrint = fingerPrint;
}







@end
