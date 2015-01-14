//
//  ViewController.m
//  Shapes
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"
#import "Rectangle.h"
#import "Triangle.h"
#import "Ellipse.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// Make 3 classes based on UIView (Rectangle, Ellipse, Triangle)
//  - Should mean what they look like if you add the shapes to the view based on the frame of the view.

// Uncomment the drawRect function

// Google CGContext drawing in drawRect

// 10 different shapes all together with different colors (of those three types)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int padding = 0;
    
    Rectangle *firstRectangle = [[Rectangle alloc] initWithFrame:CGRectMake(padding, padding, SCREEN_WIDTH-padding*2, (SCREEN_HEIGHT-padding)/3)];
    firstRectangle.alpha = 1;
    firstRectangle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstRectangle];

    
    Triangle *firstTriangle = [[Triangle alloc] initWithFrame:CGRectMake(padding, SCREEN_HEIGHT/3+padding, SCREEN_WIDTH-padding*2, (SCREEN_HEIGHT-padding)/3)];
    firstTriangle.alpha = .5;
    firstTriangle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstTriangle];

    Ellipse *firstEllipse = [[Ellipse alloc] initWithFrame:CGRectMake(padding, SCREEN_HEIGHT/3*2+padding, SCREEN_WIDTH-(padding*2), (SCREEN_HEIGHT-padding)/3)];
    firstEllipse.alpha = .5;
    firstEllipse.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstEllipse];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
