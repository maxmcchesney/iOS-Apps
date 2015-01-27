//
//  ViewController.m
//  MyFriends
//
//  Created by Michael McChesney on 1/22/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//
//Homework :
//- new app named my friends
//- uses parse (save user with username and password)
//- tableviewcontroller that shows friends (user query... this is special case look into how to query user's)
//- have a column on user class "friends" that is an array (when a friend is selected, add them to currentuser's friend array)

#import "ViewController.h"
#import <Parse/Parse.h>
#import "friendsTVC.h"
#import "CurrentFriendsTVC.h"
IB_DESIGNABLE
@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.titleLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    
//    NSAttributedString *usernamePlaceholder = [NSAttributedString alloc] initWithString:@"Username" attributes:<#(NSDictionary *)#>
    
//    self.usernameTextField.attributedPlaceholder = @"Username";
//    self.passwordTextField.attributedPlaceholder = @"Password";
    self.passwordTextField.delegate = self;
    self.usernameTextField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self signUpUser:self];     // THIS RIGHT?
    
    return YES;
}


- (IBAction)signUpUser:(id)sender {
    
    [PFUser currentUser].username = self.usernameTextField.text;
    [PFUser currentUser].password = self.passwordTextField.text;
//    [PFUser logInWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
    [[PFUser currentUser] saveInBackground];
    
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
    
//    friendsTVC * friendsView = [[friendsTVC alloc] init];
    [self presentViewController:tabBarController animated:YES completion:nil];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
