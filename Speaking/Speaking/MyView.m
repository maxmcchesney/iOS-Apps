//
//  MyView.m
//  Speaking
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)setName:(NSString *)name {
    
    if (![name isEqualToString:@"BOSS"]) {
        
        [self.delegate changeMyNameTo:@"BOSS"];
        return;
        
    }
    
    _name = name;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
