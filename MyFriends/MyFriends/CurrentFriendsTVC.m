//
//  CurrentFriendsTVC.m
//  MyFriends
//
//  Created by Michael McChesney on 1/22/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "CurrentFriendsTVC.h"
#import <Parse/Parse.h>
@interface CurrentFriendsTVC ()

@end

@implementation CurrentFriendsTVC
{
    NSMutableArray * currentFriends;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateFriendList) userInfo:nil repeats:YES];
    
//    [self updateFriendList];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self updateFriendList];
    
}

- (IBAction)logOut:(id)sender {

//    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)updateFriendList {
    PFQuery * friendQuery = [PFQuery queryWithClassName:@"CurrentFriends"];
    
    [friendQuery orderByAscending:@"name"];
    
    [friendQuery whereKey:@"owner" equalTo:[PFUser currentUser].username];
    
//    [friendQuery includeKey:@"createdAt"];   // DOESN'T WORK
    [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count > 0) {
            currentFriends = [objects mutableCopy];
            [self.tableView reloadData];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    if (currentFriends.count > 0) {
        return currentFriends.count;
    } else {
        return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentFriendCell" forIndexPath:indexPath];
    // Configure the cell...
    
    if (currentFriends.count > 0) {
        cell.textLabel.text = currentFriends[indexPath.row][@"name"];
        cell.detailTextLabel.text = currentFriends[indexPath.row][@"age"];
    } else {
        cell.textLabel.text = @"No Friends...Yet!";
        cell.detailTextLabel.text = @"";
    }
    
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
