//
//  TableViewController.m
//  Amigos
//
//  Created by Michael McChesney on 1/22/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "TableViewController.h"
#import <Parse/Parse.h>

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemTextField;


@end

@implementation TableViewController
{
    NSMutableArray * messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    messages = [@[] mutableCopy];

    [PFUser currentUser].username = @"Snax McCheesnuts";
    [PFUser currentUser].password = @"password";
    
    [[PFUser currentUser] saveInBackground];
    
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateMessages) userInfo:nil repeats:YES];
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateMessages {
    
    // Query the database and set the returned objects (an Array) to our MutableArray.
    PFQuery * messageQuery = [PFQuery queryWithClassName:@"Message"];
    
    [messageQuery orderByDescending:@"createdAt"];     // Orders the list by when created
    //    [messageQuery whereKey:@"owner" equalTo:[PFUser currentUser]];     // Only queries current user
    [messageQuery includeKey:@"owner"];
    
    [messageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count > 0 ) {
            messages = [objects mutableCopy];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

- (IBAction)addItem:(id)sender {

    PFObject * newMessage = [PFObject objectWithClassName:@"Message"];
    
    newMessage[@"text"] = self.itemTextField.text;
    newMessage[@"owner"] = [PFUser currentUser];       // Singleton

    [newMessage saveInBackground];
    NSLog(@"%@", newMessage);
    
    self.itemTextField.text = @"";
    
    [messages insertObject:newMessage atIndex:0];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFObject * message = messages[indexPath.row];
    PFUser * owner = message[@"owner"];
    
    
    cell.textLabel.text = owner.username;
    cell.detailTextLabel.text = message[@"text"];
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        PFObject * item = messages[indexPath.row];
        
        [item deleteInBackground];
        
        [messages removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
