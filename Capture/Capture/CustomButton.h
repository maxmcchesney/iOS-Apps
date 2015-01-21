//
//  CustomButton.h
//  Capture
//
//  Created by Michael McChesney on 1/20/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerSize;
@property (nonatomic) IBInspectable UIColor * borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end
