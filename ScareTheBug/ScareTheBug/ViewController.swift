//
//  ViewController.swift
//  ScareTheBug
//
//  Created by Michael McChesney on 1/27/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {

    var bugView = UIImageView(frame: CGRectMake(0, 0, 54, 45))
    var isBugDead = false
    let squishPlayer: AVAudioPlayer
    
    var foot: CGFloat = 1
    var lastFootPrint = CGPointZero

    @IBOutlet weak var playAgainButton: UIButton!

    required init(coder aDecoder: NSCoder) {
        let squishPath = NSBundle.mainBundle().pathForResource("squish", ofType: "caf")
        println(squishPath)
        let squishURL = NSURL(fileURLWithPath: squishPath!)
        squishPlayer = AVAudioPlayer(contentsOfURL: squishURL, error: nil)
        squishPlayer.prepareToPlay()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bugView.center = view.center
        bugView.image = UIImage(named: "bug")
        
        view.addSubview(bugView)
        
        playAgainButton.hidden = true
        
        // For footprints
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "footPrints", userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var touch: UITouch? = (touches.allObjects.first as UITouch)
        var location: CGPoint? = touch?.locationInView(nil)
        println(location)

        if let loc = location {
            moveBug(loc)
        }
        
        if let t = touch {
            handleTap(t)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        var touch: UITouch? = (touches.allObjects.first as UITouch)
        
        var location: CGPoint? = touch?.locationInView(nil)
        println(location)
        
        if let loc = location {
            moveBug(loc)
        }
    }
    ////////////
    
    func footPrints() {
        
        if var presentationLayer: AnyObject! = bugView.layer.presentationLayer() {
            
            var center = CGPointMake(CGRectGetMidX(presentationLayer.frame), CGRectGetMidY(presentationLayer.frame))
            
            var xDist = (center.x - lastFootPrint.x)
            var yDist = (center.y - lastFootPrint.y)
            var distance = sqrt((xDist * xDist) + (yDist * yDist))
            
            if fabs(distance) < 10 {return}
            
            var footPrint = UIView(frame: CGRectMake(0,0,6,6))
            footPrint.backgroundColor = UIColor.blackColor()
            footPrint.layer.cornerRadius = 3
            footPrint.center = CGPointMake(center.x + (foot * 3), center.y + (foot * 3))
            
            lastFootPrint = footPrint.center
            
            view.insertSubview(footPrint, atIndex: 0)
        }
        foot = foot == -1 ? 1 : -1      // To switch footprint side
    }
    
    
    ////////////
    
    func moveBug(point: CGPoint) {
        
        if point.x < bugView.center.x {
            faceBugRight(point)
        } else {
            faceBugLeft(point)
        }
    }
    
    //////////////////////////

    func faceBugRight(point: CGPoint) {
        if isBugDead { return }
        
        UIView.animateWithDuration(0.25,
            delay: 0.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bugView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            },
            completion: { finished in
                println("Bug faced right!")
                self.moveBugRight(point)
        })
    }
    
    func moveBugRight(point: CGPoint) {
        if isBugDead { return }
        var bugX = self.bugView.center.x
//        var newX = bugX + (abs(point.x - bugX))
        var newX = bugX + 75
        var screenWidth = UIScreen.mainScreen().bounds.width
        if newX > screenWidth { newX = screenWidth - 50 }
        
        // To calculate change in Y
        var screenHeight = UIScreen.mainScreen().bounds.height
        var bugY = self.bugView.center.y
        var newY = bugY
        if point.y < bugY {
            newY = bugY + 50
            if newY > screenHeight { newY = screenHeight - 50 }
        } else {
            newY = bugY - 50
            if newY < 0 { newY = 50 }
        }
        
        UIView.animateWithDuration(1.0,
            delay: 0.25,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bugView.center = CGPoint(x: newX, y: newY)
            },
            completion: { finished in
                println("Bug moved right!")

        })
    }
    
    func faceBugLeft(point: CGPoint) {
        if isBugDead { return }
        
        UIView.animateWithDuration(0.25,
            delay: 0.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bugView.transform = CGAffineTransformMakeRotation(0.0)
            },
            completion: { finished in
                println("Bug faced left!")
                self.moveBugLeft(point)
        })
    }
    
    func moveBugLeft(point: CGPoint) {
        if isBugDead { return }
        
        var bugX = self.bugView.center.x
//        var newX = bugX - (abs(point.x - bugX))
        var newX = bugX - 75
        if newX < 0 { newX = 50 }
        
        // To calculate change in Y
        var screenHeight = UIScreen.mainScreen().bounds.height
        var bugY = self.bugView.center.y
        var newY = bugY
        if point.y < bugY {
            newY = bugY + 50
            if newY > screenHeight { newY = screenHeight - 50 }
        } else {
            newY = bugY - 50
            if newY < 0 { newY = 50 }
        }
        
        UIView.animateWithDuration(1.0,
            delay: 0.25,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bugView.center = CGPoint(x: newX, y: newY)
            },
            completion: { finished in
                println("Bug moved left!")

        })
    }
    
    func handleTap(touch: UITouch) {
        let tapLocation = touch.locationInView(bugView.superview)
        if bugView.layer.presentationLayer().frame.contains(tapLocation) {
            println("Bug tapped!")
            // add bug-squashing code here
            
            if isBugDead { return }
//            view.removeGestureRecognizer(tap!)
            isBugDead = true
            squishPlayer.play()
            UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseOut, animations: {
                self.bugView.transform = CGAffineTransformMakeScale(1.25, 0.75)
                }, completion: { finished in
                    UIView.animateWithDuration(0.25, delay: 0.2, options: nil, animations: {
                        self.bugView.alpha = 0.0
                        }, completion: { finished in
                            self.bugView.removeFromSuperview()
                            
                            self.playAgainButton.hidden = false
                            
                    })
            })
            
        } else {
            println("Bug not tapped!")
        }
    }
    
    @IBAction func playAgain(sender: AnyObject) {
        isBugDead = false;
        self.bugView.alpha = 1.0
        view.addSubview(bugView)
        playAgainButton.hidden = true
    }

    //////////////////////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





