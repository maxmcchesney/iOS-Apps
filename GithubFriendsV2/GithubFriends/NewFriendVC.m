//
//  NewFriendVC.m
//  GithubFriends
//
//  Created by Michael McChesney on 1/8/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "NewFriendVC.h"
//IB_DESIGNABLE

@interface NewFriendVC ()

@end

@implementation NewFriendVC

{
    UITextField * usernameField;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    USERNAME
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 75, 300, 40)];
    usernameField.placeholder = @" Username";
    [self.view addSubview:usernameField];
    //my code
    usernameField.backgroundColor = [UIColor whiteColor];
    usernameField.layer.cornerRadius = 5;
//    usernameField.enablesReturnKeyAutomatically = YES;     - How to get the Return Key to work as well?
    
//    SAVE NEW USER
    UIButton * saveFriend = [[UIButton alloc] initWithFrame:CGRectMake(10, 125, 300, 40)];
    [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
    [saveFriend addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveFriend];
    //my code
    saveFriend.backgroundColor = [UIColor greenColor];
    saveFriend.layer.cornerRadius = 10;
    
    
//    CANCEL ADD
    UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 175, 300, 40)];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    //my code
    cancel.backgroundColor = [UIColor redColor];
    cancel.layer.cornerRadius = 10;
    
    
}


- (void)save {
    
    NSString * username = usernameField.text;
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
    
    NSURL * url = [NSURL URLWithString:urlString];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    [self.friends addObject:userInfo];
    
//    Just running the cancel method as a way of dismissing the view controller
    [self cancel];

}

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
