//
//  ViewController.h
//  Basics
//
//  Created by Michael McChesney on 1/5/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *myUsername;

@property (weak, nonatomic) IBOutlet UITextField *myEmail;

@property (weak, nonatomic) IBOutlet UITextField *myPassword;

- (IBAction)logButtonPressed:(id)sender;

- (IBAction)clearButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *myUsernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *myEmailLabel;

@property (weak, nonatomic) IBOutlet UILabel *myPasswordLabel;





@end

