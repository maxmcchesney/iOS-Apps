// Playground - noun: a place where people can play

import UIKit

// protocol RobotDelegate
protocol Listener {
    
    func batteryRunningLow()

}

enum RobotSize {
    
    case Tiny
    case Medium
    case Big
    case WorldEnder
}

class Robot {
    
    // @property (nonatomic, assign) id <RobotDelegate> myHuman;
    // var myHuman: RobotDelegate?
    var myHuman: Listener?
    
    var size: RobotSize? {
        
        didSet {
            
            if let s = size {
            
                switch s {
                    case .Tiny :
                        batteryPower = 100
                    case .Medium :
                        batteryPower = 200
                    case .Big :
                        batteryPower = 300
                    case .WorldEnder :
                        batteryPower = 1000000
                }
            }
        }
    }
    
    var batteryPower: Int = 100 {
        didSet {
            if batteryPower < 30 {
                myHuman?.batteryRunningLow()
            }
        }
    }
    
    func doTask() {
        batteryPower -= 20
    }
    
}

class Human: Listener {
    
    var myRobot: Robot?
    
    func makeRobot() {
        myRobot = Robot()
        myRobot?.myHuman = self
        myRobot?.size = .WorldEnder
    }
    
    func batteryRunningLow() {
        println("robot is dying")
    }
    
}

var Elias = Human()

Elias.makeRobot()
Elias.myRobot?.size = .Big
Elias.myRobot?.batteryPower

var Bobby = Human()

Bobby.makeRobot()
Bobby.myRobot?.size = .Medium
Bobby.myRobot?.batteryPower

var batteryPower = Bobby.myRobot?.batteryPower

var number = 5


    if let bP = batteryPower {       // unwraps batteryPower
    
var totalBatteryPower = bP + number

}

var random = arc4random_uniform(100) + 1
var luck = ""

switch random {
    
case 1...20 :
    luck = "Bad Luck"
case 20...50 :
    luck = "Average Luck"
case 50...70 :
    luck = "Lucky"
default :
    luck = "Play the lottery"
}



enum ArrowKeys: String {

    case Up = "The Up Arrow"
    case Down = "The Down Arrow"
    case Left = "The Left Arrow"
    case Right = "The Right Arrow"

}

ArrowKeys.Right.rawValue

for i in 0...100 {
    var num = Double(i) / Double(arc4random_uniform(100))
}





















