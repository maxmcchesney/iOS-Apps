//
//  SettingsViewController.swift
//  CoreList
//
//  Created by Michael McChesney on 2/24/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

var yellowSlider: Double = 0.5
var redSlider: Double = 1

@IBDesignable class SettingsViewController: UIViewController {
    
    @IBOutlet weak var timeUntilYellowLabel: UILabel!
    
    @IBOutlet weak var timeUntilRedLabel: UILabel!
    
    @IBAction func yellowSliderChanged(sender: UISlider) {
        yellowSlider = (round(Double(sender.value * 10)) / 10)
        
        timeUntilYellowLabel.text = "Days Until Yellow: \(yellowSlider)"
    }
    
    @IBAction func redSliderChanged(sender: UISlider) {
        redSlider = (round(Double(sender.value * 10)) / 10)

        timeUntilRedLabel.text = "Days Until Red: \(redSlider)"
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        timeUntilYellowLabel.text = "Days Until Yellow: \(yellowSlider)"
        timeUntilRedLabel.text = "Days Until Red: \(redSlider)"
        
        // Do any additional setup after loading the view.
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
