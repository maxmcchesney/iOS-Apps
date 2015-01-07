//
//  Body.h
//  Human
//
//  Created by Michael McChesney on 1/6/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Leg;
@class Head;
@class Arm;

@interface Body : NSObject

@property (nonatomic) Leg * leg;
@property (nonatomic) Head * head;
@property (nonatomic) Arm * arm;

@end
