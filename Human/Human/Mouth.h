//
//  Mouth.h
//  Human
//
//  Created by Michael McChesney on 1/6/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Teeth;
@class GoldTooth;

@interface Mouth : NSObject

@property (nonatomic) Teeth * teeth;

@property (nonatomic) GoldTooth * goldTooth;

- (BOOL)chewFood:(int)foodSize;

@end
