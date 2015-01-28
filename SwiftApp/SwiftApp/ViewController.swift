//
//  ViewController.swift
//  SwiftApp
//
//  Created by Michael McChesney on 1/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

let RED = UIColor.redColor() //Constant variable that, b/c it's outside of the class below, can be used throughout the entire app.
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController {

    var viewColor = UIColor.grayColor()
    
    class func sayWord(#word: String, andWord word2: String) {
    }
    
    func addNumbers(number1: Int, number2: Int) -> Int {
        return number1 + number2
    }
    
    var name: String? {
        
        willSet {
            println(name)
            println(newValue)
        }
        
        didSet {
            println(name)
        }
        
    }
    
    // TO TURN A PROPERTY INTO READ-ONLY
    var hometown: String {
        get {
            return "hometown"
        }
    }
    
    var firstName = ""
    var lastName = ""
    
    var fullName: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        ViewController.sayWord(word: "hi", andWord: "hello")
        
        // [self addNumbers:5 :3];
        self.addNumbers(5, number2: 3)
        // But, you don't need self! (except for in some situations)
        addNumbers(5, number2: 3)
        
        firstName = "Max"
        lastName = "McChesney"
        
        println(name)   // WONT WORK BECAUSE NO SETTER MAKES THIS READ ONLY
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

