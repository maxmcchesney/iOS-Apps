//
//  Dot.swift
//  Archive
//
//  Created by Michael McChesney on 2/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class Dot: NSObject, NSCoding {
    
    var center: CGPoint!
    var diameter: CGFloat = 1
    var color: UIColor = UIColor.blackColor()
    
    required init(coder aDecoder: NSCoder) {
        
        // unarchive
        
        center = aDecoder.decodeCGPointForKey("center")
        diameter = CGFloat(aDecoder.decodeFloatForKey("diameter"))
        if let c = aDecoder.decodeObjectForKey("color") as? UIColor {
            color = c
        }
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        // archive
        
        aCoder.encodeCGPoint(center, forKey: "center")
        aCoder.encodeFloat(Float(diameter), forKey: "diameter")
        aCoder.encodeObject(color, forKey: "color")
        
    }
    
    init(center: CGPoint) {
        super.init()
        self.center = center
    }
    
    convenience init(center: CGPoint, color: UIColor) {
        self.init(center: center)
        self.color = color
    }

    convenience init(center: CGPoint, diameter: CGFloat) {
        self.init(center: center)
        self.diameter = diameter
    }
    
    convenience init(center: CGPoint, color: UIColor, diameter: CGFloat) {
        self.init(center: center, color: color)
        self.diameter = diameter
    }
    
}
