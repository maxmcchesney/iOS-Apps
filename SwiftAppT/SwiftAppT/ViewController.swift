//
//  ViewController.swift
//  SwiftAppT
//
//  Created by Michael McChesney on 1/27/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func logInUser(sender: AnyObject) {
        
        var fieldValues: [String] = [usernameField.text, passwordField.text,emailField.text]
        
        if find(fieldValues, "") != nil {
            // all fields are not filled in
            
            var alertViewController = UIAlertController(title: "Submission Error", message: "All fields need to be filled in.", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else {
            // all fields are filled in
            println("All fields are good. Logged In.")
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

