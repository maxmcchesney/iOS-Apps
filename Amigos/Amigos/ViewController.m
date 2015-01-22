//
//  ViewController.m
//  Amigos
//
//  Created by Michael McChesney on 1/22/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"

#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
    testObject[@"name"] = @"Max";
    [testObject saveInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
