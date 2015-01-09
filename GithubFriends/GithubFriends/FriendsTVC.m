//
//  FriendsTVC.m
//  GithubFriends
//
//  Created by Michael McChesney on 1/8/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "FriendsTVC.h"
#import "FriendCell.h"
#import "NewFriendVC.h"
#import "FriendDetailVC.h"

@interface FriendsTVC ()

@end

@implementation FriendsTVC

{
    NSMutableArray * friends;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    friends = [@[
                @{
                    @"id": @7226122,
                    @"avatar_url": @"https://avatars.githubusercontent.com/u/7226122?v=3",
                    @"login": @"maxmcchesney",
                    @"name": @"Max McChesney",
                    @"company": @"",
                    @"blog": @"",
                    @"location": @"Atlanta, GA",
                    @"email": @"",
                    @"public_repos": @4,
                    @"public_gists": @0,
                    @"followers": @0,
                    @"following": @3
                 }
               ] mutableCopy];
    
    [self.tableView registerClass:[FriendCell class]
           forCellReuseIdentifier:@"friendCell"];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem * addFriendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    
    self.navigationItem.rightBarButtonItem = addFriendButton;

    
    
}



- (void)addFriend {
    
//    add friend to the array
    
    UINavigationController *nC2 = [[UINavigationController alloc] init];
    
    NewFriendVC *newFriendVC = [[NewFriendVC alloc] init];

    newFriendVC.view.backgroundColor = [UIColor grayColor];
    
    newFriendVC.friends = friends;
    
    nC2.viewControllers = @[newFriendVC];
    
    [self presentViewController:nC2 animated:YES completion:nil];
    
}

// Presents new FrientDetailVC and passes along username
- (void)seeDetail {
    
    //    select record and present detail VC
    
    UINavigationController *nC3 = [[UINavigationController alloc] init];
    
    FriendDetailVC *detailVC = [[FriendDetailVC alloc] init];
    
    detailVC.view.backgroundColor = [UIColor blueColor];
    
    detailVC.friendInfo = [friends valueForKeyPath:@"login"];
    
    NSLog(@"%@", detailVC.friendInfo); // Log the value to the console when it's called
    
    nC3.viewControllers = @[detailVC];
    
    [self presentViewController:nC3 animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    // Configure the cell...
    
    NSDictionary * friendInfo = friends[indexPath.row];
    
    cell.textLabel.text = friendInfo[@"name"];
    
    //avatar image
    NSURL * avatarURL = [NSURL URLWithString:friendInfo[@"avatar_url"]];
    
    NSData * imageData = [NSData dataWithContentsOfURL:avatarURL];
    
    UIImage * image = [UIImage imageWithData:imageData];
    
    cell.imageView.image = image;
    
    return cell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"something");
//    [self seeDetail];
//}


//  FINALLY, when cell is selected FriendDetailVC is presented
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath > 0) {

        NSLog(@"FINALLY");
    
        [self seeDetail];
        
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
