//
//  FriendDetailVC.m
//  GithubFriends
//
//  Created by Michael McChesney on 1/8/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

//  DONE - Add property to this class .h called "friendInfo"

//  DONE - Grab the request code from NewFriendVC.m

//  DONE - Change the url to https:://api.github.com/users/USERNAME/repos
//  DONE - Make USERNAME dynamic based on friendInfo[@"login"]

//  DONE - The return will be an NSArray of repos

//  Log the repos array

// SO goal is to touch an existing friend, present new VC, request repo info for that user, push that to new VC

//  EXTRA
//  Make selecting a cell push to FriendDetailVC
//  and set friendInfo based on cell selected



#import "FriendDetailVC.h"


@interface FriendDetailVC ()

@end

@implementation FriendDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"IT worked - %@", _friendInfo[@"login"]);
    
    NSString * username = _friendInfo[@"login"];
    
    NSString * urlString = [NSString stringWithFormat:@"https:://api.github.com/users/%@/repos", username];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    NSArray * repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
//    NSLog(@"%@", repos);
    
//    for (id key in repos) {
//        NSLog(@"key: %@, value: %@ \n", key, [repos objectForKey:key]);
//    }
    
//    NSLog(@"%@", [repos valueForKeyPath:@"public_repos"]);

    //    Back
    UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 175, 300, 40)];
    [cancel setTitle:@"Back" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    //my code
    cancel.backgroundColor = [UIColor redColor];
    cancel.layer.cornerRadius = 10;
    
    
}

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//- (void)request {
//    
//    NSString * username = _friendInfo[@"login"];
//    
//    NSString * urlString = [NSString stringWithFormat:@"https:://api.github.com/users/%@/repos", username];
//    
//    NSURL * url = [NSURL URLWithString:urlString];
//    
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSArray * repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    
//    NSLog(@"%@", repos);
//    
//}

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
