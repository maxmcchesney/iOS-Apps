// Playground - noun: a place where people can play

import UIKit
import CoreGraphics


var names: [AnyObject] = ["Jim", "Sue", "Ted", 0]

var names2: [String] = ["Jim", "Sue", "Ted"]

names2 += ["Max", "Sam"]

var str = "Hi" + ","
str += " my name is Max"

var info: [String:AnyObject] = ["name":"Max", "age":27]


var shapes = ["Circle","Square","Triangle"]

for shape in shapes {
    
    println("shape " + shape)
    
}

for i in 0...5 {
    println(i)
}

for i in 0..<shapes.count {
    
    println(shapes[i])
    
}

for (i,shape) in enumerate(shapes) {
    
    var shapeInfo = "\(i) \(shape) in \(shapes)"
    
    println(shapeInfo)
}

var myInfo = ["name":"Jo", "age":"31", "brand":"Nike"]

for (key,value) in myInfo {
    
    println("\(key) = \(value)")
    
    if key == "age" {
    
        println("my age is \(value)")
    }
    
    switch key {
        
        case "age":
            println("my age is \(value)")
        case "name":
            println("my name is \(value)")
        default :
            println("my \(key) is \(value)")
    }

}