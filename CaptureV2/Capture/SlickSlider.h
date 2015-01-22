//
//  SlickSlider.h
//  Capture
//
//  Created by Michael McChesney on 1/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlickSliderDelegate;
IB_DESIGNABLE

@interface SlickSlider : UIView

@property (nonatomic) IBInspectable CGFloat startPosition;
@property (nonatomic) IBInspectable UIColor * sliderColor;
@property (nonatomic) IBInspectable BOOL reverseColor;

@property (nonatomic, assign) id <SlickSliderDelegate> delegate;  // delegate is the LISTENING OBJECT

@end

@protocol SlickSliderDelegate <NSObject>

- (void)sliderDidFinishUpdatingWithValue:(float)value;

@end