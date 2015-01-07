//
//  ViewController.h
//  CrystalBall
//
//  Created by Michael McChesney on 12/29/14.
//  Copyright (c) 2014 DigitalCrafts. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CrystalBall;

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *predictionLabel;
@property (strong, nonatomic) CrystalBall *crystalBall;
- (IBAction)buttonPressed;


@end

