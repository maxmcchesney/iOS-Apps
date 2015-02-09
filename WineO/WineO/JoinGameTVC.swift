//
//  JoinGameTVC.swift
//  WineO
//
//  Created by Michael McChesney on 2/2/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class JoinGameTVC: UITableViewController {

    var existingGames = []
//    var gameMember = PFObject(className:"Games")
    var query = PFQuery(className: "Games")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        updateGameList()
        
    }

    func updateGameList() {
        
        query.findObjectsInBackgroundWithBlock { (object: [AnyObject]!, error: NSError!) -> Void in
            
            if object.count > 0 {
                self.existingGames = object
//                println(self.existingGames)
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.updateGameList()
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
        return existingGames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as UITableViewCell

        let game: AnyObject = existingGames[indexPath.row]

        cell.textLabel?.text = game["groupName"] as? String
        cell.detailTextLabel?.text = "Current players: "
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

//        let gameSelected: AnyObject = existingGames[indexPath.row]
//        let gameId: String? = gameSelected["objectId"] as? String

//        println("Game selected: \(gameSelected)")
        

        let vc = InGameTVC()
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }

        
        }
        
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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


