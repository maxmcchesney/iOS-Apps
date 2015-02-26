//
//  ViewController.swift
//  Archive
//
//  Created by Michael McChesney on 2/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

private let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0] as String

class ViewController: UIViewController {
    
    let dotsData = documentsDirectoryPath + "/dots.data"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println(documentsDirectoryPath)
        
        loadDots()
        
        NSNotificationCenter.defaultCenter().addObserverForName("appIsClosing", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.saveDots()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func saveDots() {
        
        // get dots from boardview
        // archive dots to file path
        
        let bView = self.view as BoardView
        
        NSKeyedArchiver.archiveRootObject(bView.dots, toFile: dotsData)
        
    }
    
    func loadDots() {
        
        // get file path for dots archive
        // unarchive file path to dots array
        // set boardview dots
        
        let bView = self.view as BoardView
        
        println(NSFileManager.defaultManager().fileExistsAtPath(dotsData))
        
        if let dots = NSKeyedUnarchiver.unarchiveObjectWithFile(dotsData) as? [Dot] {
            
            bView.dots = dots
            bView.setNeedsDisplay()
            
        }
        
    }
    
    
    @IBAction func clearDots(sender: AnyObject) {
        
        let bView = self.view as BoardView
        bView.dots = []
        
        NSKeyedArchiver.archiveRootObject(bView.dots, toFile: dotsData)
        
        bView.setNeedsDisplay()
    }
    
    
}

