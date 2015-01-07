//
//  ListTVC.m
//  List
//
//  Created by Michael McChesney on 1/7/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ListTVC.h"
#import "ListCell.h"

//  Finish coloring & laying out the TableViewCell based on design

//  DONE - Change row height

//  DONE - Make the separator go all the way to the right side

//  Listen for touches on the cell (will use for stike through)

//  Listen for touches on the colorView (will use for toggling the color)

//  DONE - Add 10 items to array

//Extra:
//  Add swipe to delete
//  Make the array mutable


@interface ListTVC ()

@end

@implementation ListTVC

{
    NSArray * listItems;
}
//  ^ Local instance variables should go in brackets like above. Purpose is so the instance variables will be available throughout the life cycle of the object it's in.

- (instancetype)init {
    
    self = [super init];
    
    self.view.backgroundColor = [UIColor blackColor];    
    
    if (self) {
        
//        listItems = [NSArray arrayWithObjects:@"item1", @"item2", nil];    Long way to write an array. use @[@"", @""]; instead.

//        NSDictionary * d = [[NSDictionary alloc] initWithObjectsAndKeys:@"", @"", [UIColor greenColor], @"", nil];   The long way to write a dictionary
        
//        NSDictionary * sd = @{
//                              @"text":@"this is the text",
//                              @"color":[UIColor greenColor]
//                              };
//        
//        listItems = @[
//                      @"item1",
//                      @"item2"
//                      ];

        listItems = @[
                      
                      @{
                          @"text":@"Milk",
                          @"color":[UIColor greenColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Oranges",
                          @"color":[UIColor orangeColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Bananas",
                          @"color":[UIColor purpleColor],
                          @"done":@YES
                          },
                      @{
                          @"text":@"Yogurt",
                          @"color":[UIColor blackColor],
                          @"done":@YES
                          },
                      @{
                          @"text":@"Steak",
                          @"color":[UIColor redColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Grapes",
                          @"color":[UIColor grayColor],
                          @"done":@YES
                          },
                      @{
                          @"text":@"Chicken Salad",
                          @"color":[UIColor yellowColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Quinoa",
                          @"color":[UIColor blueColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Roast Beef",
                          @"color":[UIColor brownColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Cereal",
                          @"color":[UIColor grayColor],
                          @"done":@YES
                          },
                      @{
                          @"text":@"Gatorade",
                          @"color":[UIColor purpleColor],
                          @"done":@YES
                          },
                      @{
                          @"text":@"Smokes",
                          @"color":[UIColor orangeColor],
                          @"done":@NO
                          },
                      @{
                          @"text":@"Barley",
                          @"color":[UIColor blackColor],
                          @"done":@YES
                          }

                      
                      ];
        
        
//      listItems.count   returns the number of items in array
//      [listItems objectAtIndex:0]   returns the item at that point in the array
        
    }
    
    return self;
    
}
//  ^ instancetype is just like id, it's a wild card. This is for overriding init. You would do this for 2 reasons:

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
//    [self.tableView addGestureRecognizer:tap];
    
    
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
    return listItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil) {
        
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
//    NSDictionary * listItem = listItems[indexPath.row];
    
    cell.itemInfo = listItems[indexPath.row];
    
    // Configure the cell...


    
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
