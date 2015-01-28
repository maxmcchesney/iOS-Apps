//
//  ViewController.swift
//  Break
//
//  Created by Michael McChesney on 1/28/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
    
    @IBOutlet weak var gameView: UIView!
    
    var animator: UIDynamicAnimator?
    
    var gravityBehavior = UIGravityBehavior()
    var collisionBehavior = UICollisionBehavior()
    var ballBehavior = UIDynamicItemBehavior()
    var brickBehavior = UIDynamicItemBehavior()
    var paddleBehavior = UIDynamicItemBehavior()
    
    var paddle = UIView(frame: CGRectMake(0, 0, 100, 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: gameView)
        
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(collisionBehavior)
        animator?.addBehavior(ballBehavior)
        animator?.addBehavior(brickBehavior)
        animator?.addBehavior(paddleBehavior)
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        
        
        ballBehavior.friction = 0
        ballBehavior.elasticity = 1
        ballBehavior.resistance = 0
        ballBehavior.allowsRotation = false

        brickBehavior.density = 1000000
        
        paddleBehavior.density = 1000000
        
        
        createBall()
        createBricks()
        createPaddle()
        
    }
    
//    LISTEN FOR COLLISSIONS WITH THE BRICKS
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        
        ballBehavior.items
        brickBehavior.items
        
        for brick in brickBehavior.items as [UIView] {
            if brick.isEqual(item1) || brick.isEqual(item2) {
                
                brickBehavior.removeItem(brick)
                collisionBehavior.removeItem(brick)
                brick.removeFromSuperview()
                
            }
        }
    }
    
//    CREATE THE BALL / HEAD IMAGE
    func createBall() {

        let josFace = "Jos_face_small.png"
        let image = UIImage(named: josFace)
        let ball = UIImageView(image: image!)
        ball.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        gameView.addSubview(ball)
        
//        var ball = UIView (frame: CGRectMake(0, 0, 20, 20))

        
        ball.center = gameView.center
//        ball.backgroundColor = UIColor.orangeColor()
        ball.layer.cornerRadius = 20
        gameView.addSubview(ball)
        
//        gravityBehavior.addItem(ball)
        collisionBehavior.addItem(ball)
        ballBehavior.addItem(ball)
        
        var pushBehavior = UIPushBehavior(items: [ball], mode: .Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.25, -0.25)
        animator?.addBehavior(pushBehavior)
    }
    
//    CREATE THE BRICKS
    func createBricks() {
        
        var grid = (6,4)        // Tuple  grid.0, grid.1, etc.
        var gap: CGFloat = 10
        var width = (SCREEN_WIDTH - (gap * CGFloat(grid.0 + 1))) / CGFloat(grid.0)
        var height: CGFloat = 20
        
        for c in 0..<grid.0 {
            
            for r in 0..<grid.1 {
            
                var x = CGFloat(c) * (width + gap) + gap
                var y = CGFloat(r) * (height + gap) + 70
                
                var brick = UIView(frame: CGRectMake(x, y, width, height))
                brick.backgroundColor = UIColor.blackColor()
                brick.layer.cornerRadius = 3
                
                gameView.addSubview(brick)
                
                collisionBehavior.addItem(brick)
                brickBehavior.addItem(brick)
//                gravityBehavior.addItem(brick)
                
            }
            
        }
        
    }
    
    var attachmentBehavior: UIAttachmentBehavior?
    
//   CREATE THE PADDLE
    func createPaddle() {
        
        paddle.center.x = view.center.x
        paddle.center.y = SCREEN_HEIGHT - 40
        paddle.backgroundColor = UIColor.blueColor()
        paddle.layer.cornerRadius = 2
        gameView.addSubview(paddle)
        
        collisionBehavior.addItem(paddle)
        paddleBehavior.addItem(paddle)
        
        attachmentBehavior = UIAttachmentBehavior(item: paddle, attachedToAnchor: paddle.center)
        animator?.addBehavior(attachmentBehavior)
        
    }
    
//    LISTEN FOR TOUCHES TO MOVE THE PADDLE
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        if let touch = touches.allObjects.first as? UITouch {
            
            let location = touch.locationInView(gameView)
//            paddle.center.x = location.x
            attachmentBehavior?.anchorPoint.x = location.x
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

