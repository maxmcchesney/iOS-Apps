//
//  TableViewController.swift
//  CoreList
//
//  Created by Michael McChesney on 2/24/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

// Labwork :
// - DONE - make the cell show the created date
// - DONE - change color of cell background based on time since creation [green, yellow, red]
// - DONE - add fetch predicate & sortdescriptor to order based on creation date (oldest first)
// - DONE - make background grey and text white if completed
// - DONE - tap cell to toggle completed

// Bonus :
// - DONE - allow deleting items
// - create 2 sections [non-completed, completed]
//   - would have 2 different fetches that filter out completed vs noncompleted, and save to two seperate arrays instead of just items

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var items: [AnyObject] = []
    
    let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func viewWillAppear(animated: Bool) {
        
        // fetch from CoreData and reload tableView
        
        let entity = NSEntityDescription.entityForName("Items", inManagedObjectContext: applicationDelegate.managedObjectContext!)
        
        let fetch = NSFetchRequest()
        
        fetch.entity = entity
        
        // Create a sort descriptor object that sorts on the "created"
        // property of the Core Data object
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        fetch.sortDescriptors = [sortDescriptor]

        
        if let results = applicationDelegate.managedObjectContext?.executeFetchRequest(fetch, error: nil) {
            
            items = results

            tableView.reloadData()
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as ItemTableViewCell

        cell.checkmarkImage.hidden = true
        
        let object = items[indexPath.row] as NSManagedObject
        
        // SET TEXT LABEL TO NAME OF ITEM
        cell.itemNameLabel.text = object.valueForKey("name") as? String
        

        // SET DETAIL TEXT LABEL TO DATE CREATED
        if let date = object.valueForKey("created") as? NSDate {
            
            // DATE AND TIME LABEL
            
            // Formatter for date string
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            var dateString = dateFormatter.stringFromDate(date)
            // Formatter for time string
            let formatterTime = NSDateFormatter()
            formatterTime.timeStyle = .ShortStyle //Set style of time
            var timeString = formatterTime.stringFromDate(date) //Convert to String
            // Set label for date/time created rather than time since creation
//            cell.dateLabel.text = dateString + " " + timeString
            

            // TIME TRIGGERS BACKGROUND COLOR (measured in hours)
            let day: Double = 24 //hrs
            /// minutes since creation for green threshold
//            let greenThreshold: Double = 1 * day
            let greenThreshold = yellowSlider * day
            /// minutes since creation for yellow threshold
//            let yellowThreshold: Double = 2 * day
            let yellowThreshold = redSlider * day


            let interval = abs(date.timeIntervalSinceNow / 60 / 60)
            println(interval)
            if interval <= greenThreshold {
                cell.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.1)
            } else if interval < yellowThreshold {
                cell.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.1)
            } else {
                cell.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.1)
            }
            
            // change date label to 'created x hours ago', etc.
            updateTimes(interval, cell: cell)
            
            // update times with a timer
//            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimes:", userInfo: nil, repeats: true)

            
        }
        
        let completed = object.valueForKey("completed") as Bool

        if completed {
            
            cell.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.2)

            cell.checkmarkImage.hidden = false
            
        }

        return cell
    }
    
    func updateTimes(interval: Double, cell: ItemTableViewCell) {
            // change date label to 'created x hours ago', etc.
        println("times updated")
        if interval <= 1 {
            cell.dateLabel.text = "created \(Int(round(interval * 60))) minutes ago"
        } else if interval <= 24 {
            cell.dateLabel.text = "created \(Int(round(interval))) hours ago"
        } else {
            cell.dateLabel.text = "created \(Int(round(interval / 24))) days ago"
        }

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let object = items[indexPath.row] as NSManagedObject

        let completed = object.valueForKey("completed") as Bool
        
        object.setValue(!completed, forKey: "completed")

        applicationDelegate.saveContext()
        
        tableView.reloadData()
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
        
            let object = items[indexPath.row] as NSManagedObject
            
            applicationDelegate.managedObjectContext?.deleteObject(object)

           items.removeAtIndex(indexPath.row)

            applicationDelegate.saveContext()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            tableView.reloadData()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
