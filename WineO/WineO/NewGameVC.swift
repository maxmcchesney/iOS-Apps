//
//  NewGameVC.swift
//  WineO
//
//  Created by Michael McChesney on 2/2/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit



class NewGameVC: UIViewController {
    
    @IBOutlet weak var groupNameField: UITextField!
    @IBOutlet weak var groupCodeField: UITextField!
    
    var newGame = PFObject(className:"Games")

    override func viewDidLoad() {
        super.viewDidLoad()


    
        
        
    }
    
    
    @IBAction func createNewGame(sender: AnyObject) {
//        SAVE NEW GAME TO PARSE
        newGame["groupName"] = groupNameField.text
        newGame["groupCode"] = groupCodeField.text
        newGame["host"] = PFUser.currentUser().username
        newGame.saveInBackground()
        println("New game created")
        println(newGame)
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
