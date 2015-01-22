//
//  CustomButton.h
//  Capture
//
//  Created by Michael McChesney on 1/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerSize;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor * borderColor;

@end
