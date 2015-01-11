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


@interface FriendDetailVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FriendDetailVC
{
    NSArray *repos;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
//    Get repo data from github
    NSString * username = self.friendInfo[@"login"];
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", username];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    Had to change this to an Array because when you go to the URL in the browser, the top indicator is a [, meaning you're retrieving an array. (In the other part, it was a {, or a Dictionary.)
    repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 368)];

    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
//    MY CODE HERE FOR PUTTING THE PIC ABOVE THE TABLE CELLS
    UIImageView * viewPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 203)];
    
    viewPic.backgroundColor = [UIColor lightGrayColor];
    
    viewPic.image = self.avatar;

    [self.view addSubview:viewPic];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
//    Set up the repo info in the cells. Go to the URL in the browser and see what you want to display. We chose @"name" and @"descrition".
    
    cell.textLabel.text = repos[indexPath.row][@"name"];    //Two sets of [] allows you to access deeper info in an Array/Dictionary.
    
//    We originally had a crash here b/c some descriptions had a <null> value (which we saw in the error). T
    if (repos[indexPath.row][@"description"] == [NSNull null]) {
        
    } else {
        
        cell.detailTextLabel.text = repos[indexPath.row][@"description"];
        
    }
    
    
    
    return cell;
    
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
