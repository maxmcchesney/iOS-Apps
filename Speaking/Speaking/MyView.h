//
//  MyView.h
//  Speaking
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyViewDelegate;

@interface MyView : UIView

@property (nonatomic) NSString * name;

@property (nonatomic,assign) id <MyViewDelegate> delegate;

@end

@protocol MyViewDelegate <NSObject>

- (void)changeMyNameTo:(NSString *)name;

@end