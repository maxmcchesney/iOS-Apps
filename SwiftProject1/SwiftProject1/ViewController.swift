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
    @IBOutlet weak var signUpLogInButton: UIButton!
    @IBOutlet weak var createAccountLabel: UILabel!

    
//    func saveUser() {
//        
//        var user = PFObject(className: "User")
//        user.setObject(usernameField.text, forKey: "username")
//        user.setObject(passwordField.text, forKey: "password")
//        user.setObject(emailField.text, forKey: "email")
//        user.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
//            if (success != nil) {
//                NSLog("User created with id: \(user.objectId)")
//            } else {
//                NSLog("%@", error)
//            }
//        })
//        
//        usernameField.text = ""
//        passwordField.text = ""
//        confirmPasswordField.text = ""
//        emailField.text = ""
//        messageLabel.textColor = UIColor.blueColor()
//        messageLabel.text = "Success!"
//    }
    
    func signUp() {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                
                println(user)
                self.usernameField.text = ""
                self.passwordField.text = ""
                self.confirmPasswordField.text = ""
                self.emailField.text = ""
                self.messageLabel.textColor = UIColor.blueColor()
                self.messageLabel.text = "Account Created!"
                
            } else {
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                println(errorString)
                
//                if (errorString == "username \(self.usernameField.text) already taken") {
//                    self.messageLabel.textColor = UIColor.redColor()
//                    self.messageLabel.text = "Username already taken!"
//                }
            }
        }
    }
    
    @IBAction func logIn(sender: AnyObject) {
        
        var fieldValues: [String] = [usernameField.text, passwordField.text, confirmPasswordField.text, emailField.text]
        
        if find(fieldValues, "") != nil {
            // all fields are not filled in
//            messageLabel.text = "Please fill in all the blanks!"
            
            var alertViewController = UIAlertController(title: "Error", message: "Please fill in all fields!", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else if (passwordField.text != confirmPasswordField.text) {
            
            messageLabel.text = "Passwords do not match."
            
        } else {
            // all fields are filled in
            
            var userQuery = PFUser.query()
            userQuery.whereKey("username", equalTo: usernameField.text)
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    self.userLogIn()
                } else {
                    self.signUp()
                }
                
            })
//            signUp()
        }

    }
    
    @IBAction func logInButtonPressed(sender: AnyObject) {
        // Change Sign Up button to Log in and hide confirm pw field and email field
        emailField.hidden = true
        confirmPasswordField.hidden = true

        signUpLogInButton.setTitle("Log In", forState: UIControlState.Normal)
        createAccountLabel.text = "Log In"
        usernameField.placeholder = "Username"
        
    }
    
    
    
    func userLogIn() {
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("Logged in as \(user)")
                self.usernameField.text = ""
                self.passwordField.text = ""
                self.confirmPasswordField.text = ""
                self.emailField.text = ""
                self.messageLabel.textColor = UIColor.blueColor()
                self.messageLabel.text = "Logged In!"
                
            } else {
                // The login failed. Check error to see why.
                println(error)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        var userQuery = PFQuery(className: "User")
        //        userQuery.whereKey("username", equalTo: usernameField.text)
        //        userQuery.findObjects()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

