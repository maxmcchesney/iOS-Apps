//
//  ViewController.m
//  Basics
//
//  Created by Michael McChesney on 1/5/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"

//  Create 2 View Controllers on the main storyboard

//  View Controller 1
//  - 2 buttons (one will clear textfields, one will log all text fields)
//  - 3 textfields (username, email, password)
//  - password field should look like one by hiding the text with dots (look in the right panel)
//  - email field should use email keyboard (also in right panel)

//  View Controller 2
//  - 4 buttons with different color backgrounds
//  - each button changes the main view controller's backaground color

//  Add constraints
//  Make the buttons on view controller 2 circles with no text

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logButtonPressed:(id)sender {
//    Log the text fields
    
    NSLog(@"Username: %@\n", self.myUsername.text);
    NSLog(@"Email: %@\n", self.myEmail.text);
    NSLog(@"Password: %@\n", self.myPassword.text);

    self.myUsernameLabel.text = [@"Username: " stringByAppendingString:self.myUsername.text];
    self.myEmailLabel.text = [@"Email: " stringByAppendingString:self.myEmail.text];
    self.myPasswordLabel.text = [@"Password: " stringByAppendingString:self.myPassword.text];
    
}

- (IBAction)clearButtonPressed:(id)sender {
//    Clear the text fields and the logged stuff

    self.myUsernameLabel.text = @"Username Cleared!";
    self.myEmailLabel.text = @"Email Cleared!";
    self.myPasswordLabel.text = @"Password Cleared!";

}

















@end
