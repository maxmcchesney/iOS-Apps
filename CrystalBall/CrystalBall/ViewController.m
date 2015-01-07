//
//  ViewController.m
//  CrystalBall
//
//  Created by Michael McChesney on 12/29/14.
//  Copyright (c) 2014 DigitalCrafts. All rights reserved.
//

#import "ViewController.h"
#import "CrystalBall.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.crystalBall = [[CrystalBall alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed {
    
    //Change the label when the button is pressed, accessing the Array above.
    self.predictionLabel.text = [self.crystalBall randomPrediction];

    //Change color of label to red.
    self.predictionLabel.textColor = [UIColor redColor];
}







@end
