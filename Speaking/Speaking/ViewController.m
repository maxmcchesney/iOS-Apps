//
//  ViewController.m
//  Speaking
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController () <MyViewDelegate>

@end

@implementation ViewController
{
    MyView *view1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    view1 = [[MyView alloc] init];
    
    view1.delegate = self;
    
    view1.name = @"Bob";
    
    NSLog(@"viewDidLoad- %@", view1.name);
    
}

-(void)changeMyNameTo:(NSString *)name {
    
    NSLog(@"changeMyNameTo - %@", name);
    
    view1.name = name;
    
    NSLog(@"changeMyNameTo - %@", view1.name);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
