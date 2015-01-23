//
//  friendsTVC.m
//  MyFriends
//
//  Created by Michael McChesney on 1/22/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "friendsTVC.h"
#import <Parse/Parse.h>
#import "CurrentFriendsTVC.h"

@interface friendsTVC () <UIAlertViewDelegate>

@end

@implementation friendsTVC
{
    NSMutableArray *people;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    people = [@[] mutableCopy];
    
    PFQuery * peopleQuery = [PFQuery queryWithClassName:@"Friends"];
    
    [peopleQuery orderByAscending:@"name"];
    
    //    [friendQuery includeKey:@"createdAt"];   // DO I NEED THIS?
    
    [peopleQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count > 0) {
            people = [objects mutableCopy];
            [self.tableView reloadData];
        }
        
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)logOut:(id)sender {

//    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    return people.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    // Configure the cell...
    
    cell.textLabel.text = people[indexPath.row][@"name"];
    cell.detailTextLabel.text = people[indexPath.row][@"age"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject * newFriend = [PFObject objectWithClassName:@"CurrentFriends"];
    
    newFriend[@"name"] = people[indexPath.row][@"name"];
    newFriend[@"age"] = people[indexPath.row][@"age"];
    newFriend[@"owner"] = [PFUser currentUser].username;
    [newFriend saveInBackground];
    NSLog(@"%@",newFriend);
    
    NSString * message = [NSString stringWithFormat:@"%@ has been added as a new friend!", people[indexPath.row][@"name"]];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:message delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [alertView show];
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

