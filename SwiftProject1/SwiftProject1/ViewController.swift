//
//  ViewController.swift
//  SwiftProject1
//
//  Created by Michael McChesney on 1/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var userQuery = PFQuery(className: "User")
        userQuery.whereKey("username", equalTo: usernameField.text)
        userQuery.findObjects()
    }
    
    func saveUser() {
        
        var user = PFObject(className: "User")
        user.setObject(usernameField.text, forKey: "username")
        user.setObject(passwordField.text, forKey: "password")
        user.setObject(emailField.text, forKey: "email")
        user.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                NSLog("User created with id: \(user.objectId)")
            } else {
                NSLog("%@", error)
            }
        })
        
        usernameField.text = ""
        passwordField.text = ""
        confirmPasswordField.text = ""
        emailField.text = ""
        messageLabel.textColor = UIColor.blueColor()
        messageLabel.text = "Success!"
    }
    
    @IBAction func logIn(sender: AnyObject) {
        
        if (usernameField.text == "" || passwordField.text == "" || confirmPasswordField.text == "" || emailField.text == "") {
            
            messageLabel.text = "Please fill in all the blanks!"
            
        } else if (passwordField.text != confirmPasswordField.text) {
            
            messageLabel.text = "Passwords do not match."
            
        } else {
            
            saveUser()
            
        }
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

