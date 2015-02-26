//
//  ArrowButton.swift
//  FFAController
//
//  Created by Michael McChesney on 2/10/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

@IBDesignable class ArrowButton: UIButton {

    @IBInspectable var direction: String = "Right"
    @IBInspectable var buttonColor: UIColor = UIColor.blackColor()
    
    @IBInspectable var strokeSize: CGFloat = 2
    @IBInspectable var strokeColor: UIColor = UIColor.clearColor()
    
    @IBInspectable var cornerSize: CGFloat = 0
    
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let ctx = UIGraphicsGetCurrentContext()
        
        self.layer.masksToBounds = true
//        self.clipsToBounds = true
        
        let width = rect.width
        let height = rect.height
        
        
        switch direction {
            case "Right":
            
                CGContextMoveToPoint(ctx, 0, 0)
                CGContextAddLineToPoint(ctx, width, CGRectGetMidY(rect))
                CGContextAddLineToPoint(ctx, 0, height)
            
            
            case "Down":
            
                CGContextMoveToPoint(ctx, 0, 0)
                CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), height)
                CGContextAddLineToPoint(ctx, width, 0)
            
            case "Left":
            
                CGContextMoveToPoint(ctx, width, 0)
                CGContextAddLineToPoint(ctx, 0, CGRectGetMidY(rect))
                CGContextAddLineToPoint(ctx, width, height)
            
            case "Up":
            
                CGContextMoveToPoint(ctx, 0, height)
                CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), 0)
                CGContextAddLineToPoint(ctx, width, height)
            
            default:
                
                println("can't point in that direction")
            
            break
        }
        
        buttonColor.setFill()

        self.layer.cornerRadius = cornerSize
        self.layer.borderColor = strokeColor.CGColor
        self.layer.borderWidth = strokeSize
//        CGContextSetBlendMode(ctx, kCGBlendModeScreen)
        CGContextFillPath(ctx)
        
        
    }
    

}
