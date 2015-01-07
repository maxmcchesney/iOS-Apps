//
//  secondViewController.m
//  Basics
//
//  Created by Michael McChesney on 1/5/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "secondViewController.h"

@interface secondViewController ()

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)redButtonPressed:(id)sender {

    self.view.backgroundColor = [UIColor redColor];
    
}

- (IBAction)greenButtonPressed:(id)sender {

    self.view.backgroundColor = [UIColor greenColor];

}

- (IBAction)blueButtonPressed:(id)sender {

    self.view.backgroundColor = [UIColor blueColor];

}

- (IBAction)greyButtonPressed:(id)sender {

    self.view.backgroundColor = [UIColor grayColor];

}


@end





