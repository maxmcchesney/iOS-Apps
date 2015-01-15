//
//  ViewController.h
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/14/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "roundedButton.h"

@interface ViewController : UIViewController

- (IBAction)changeTheme:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet roundedButton *button1;

@property (weak, nonatomic) IBOutlet roundedButton *button2;

@property (weak, nonatomic) IBOutlet roundedButton *button3;

@property (weak, nonatomic) IBOutlet roundedButton *button4;

@property (weak, nonatomic) IBOutlet roundedButton *button5;

@property (weak, nonatomic) IBOutlet roundedButton *button6;

@end

