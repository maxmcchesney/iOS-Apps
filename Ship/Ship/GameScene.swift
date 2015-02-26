//
//  GameScene.swift
//  Ship
//
//  Created by Michael McChesney on 2/9/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

//        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
//        self.physicsWorld.gravity = CGVectorMake(0.0, -2.0)
        
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let fireBallPath = NSBundle.mainBundle().pathForResource("FireBall", ofType: "sks")
            
            let fireBall = NSKeyedUnarchiver.unarchiveObjectWithFile(fireBallPath!) as SKEmitterNode
            
            fireBall.position = location
//            fireBall.particleBirthRate = 10
            
            let physicsBody = SKPhysicsBody(circleOfRadius: 20)
            fireBall.physicsBody = physicsBody
            physicsBody.affectedByGravity = false

            self.addChild(fireBall)
            
            physicsBody.applyForce(CGVectorMake(500.0, 0.0))
        }
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
//            let circle = SKShapeNode(circleOfRadius: 20)
//            circle.fillColor = SKColor.greenColor()
//            circle.position = location
//            
//            circle.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//            
//            self.addChild(circle)

        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for child in self.children as [SKNode] {
            
            if child.position.y < -50 {
                child.removeFromParent()
                
//                child.position.y = self.frame.height + 100
                
            }
            
//            println(self.children.count)
        }
        
    }
}
