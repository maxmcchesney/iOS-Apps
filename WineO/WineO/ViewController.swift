//
//  ViewController.swift
//  WineO
//
//  Created by Michael McChesney on 2/2/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


   
    }
    
//    LOG IN OR CREATE ACCOUNT
    @IBAction func logInSignUp(sender: AnyObject) {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        // other fields can be set just like with PFObject
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println("\(self.usernameField.text) account created")

            } else {
                // Show the errorString somewhere and let the user try again.
                
                PFUser.logInWithUsernameInBackground(self.usernameField.text, password:self.passwordField.text) {
                    (user: PFUser!, error: NSError!) -> Void in
                    if user != nil {
                        // Do stuff after successful login.
                        println("\(self.usernameField.text) logged in")
                        
                    } else {
                        // The login failed. Check error to see why.
                        println("Sign up / Log in failed!")
                        // TODO: Add Alert Window here
                    }
                }
                
            }
        }
        
    }
    


    

    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

