//
//  CrystalBall.h
//  CrystalBall
//
//  Created by Michael McChesney on 12/30/14.
//  Copyright (c) 2014 DigitalCrafts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrystalBall : NSObject {
    NSArray *_predictions;
}

@property (strong, nonatomic, readonly) NSArray *predictions;

- (NSString*) randomPrediction;

@end
