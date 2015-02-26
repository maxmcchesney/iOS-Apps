//
//  ViewController.swift
//  Ball
//
//  Created by Michael McChesney on 2/10/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {
    
    var session: MCSession!
    var myPeerID: MCPeerID!
    var advertiser: MCNearbyServiceAdvertiser!
    
    let serviceType = "Brawling10"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPeerID = MCPeerID(displayName: "Hungover")
        
        session = MCSession(peer: myPeerID)
        session.delegate = self
        
        
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
        advertiser.delegate = self
        
        advertiser.startAdvertisingPeer()
        
    }
    
    func sendMove(x: CGFloat, y: CGFloat) {
        
        let moveInfo = ["x":x, "y":y]
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: .allZeros, error: nil)
        
        println(roomPeerID)
        println(session.connectedPeers)
        
        if let roomPeerID = roomPeerID {
            
            var error: NSError?
            
            session.sendData(moveData, toPeers: [roomPeerID], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
            
        }
        
    }
    

    
    @IBAction func upArrow(sender: AnyObject) {
        
        let moveInfo = ["direction":"up"]
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: .allZeros, error: nil)
        var error: NSError?
        
        if let rP = roomPeerID {
            
        session.sendData(moveData, toPeers: [rP], withMode: MCSessionSendDataMode.Reliable, error: &error)

        println(error)
            
        }
        
    }
    
    @IBAction func rightArrow(sender: AnyObject) {
        
        let moveInfo = ["direction":"right"]
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: .allZeros, error: nil)
        var error: NSError?
        
        if let rP = roomPeerID {
            
            session.sendData(moveData, toPeers: [rP], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
            
        }
        
    }
    
    @IBAction func downArrow(sender: AnyObject) {
        
    }
    
    @IBAction func leftArrow(sender: AnyObject) {
        
        let moveInfo = ["direction":"left"]
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: .allZeros, error: nil)
        var error: NSError?
        
        if let rP = roomPeerID {
            
            session.sendData(moveData, toPeers: [rP], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
            
        }
        
    }
    
    @IBAction func specialButton(sender: AnyObject) {
        
        let moveInfo = ["fire":"special"]
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: .allZeros, error: nil)
        var error: NSError?
        
        if let rP = roomPeerID {
            
            session.sendData(moveData, toPeers: [rP], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
            
        }
        
    }
    
    @IBAction func fireButton(sender: AnyObject) {
        
        let moveInfo = ["fire":"normal"]
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: .allZeros, error: nil)
        var error: NSError?
        
        if let rP = roomPeerID {
            
            session.sendData(moveData, toPeers: [rP], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
            
        }
        
    }
    
    
    
    var lastLocation: CGPoint?
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // set up touches
        if let touch = touches.allObjects.last as? UITouch {
            let location = touch.locationInView(view)
        
            if let ll = lastLocation {
                
                let xMove = location.x - ll.x
                let yMove = location.y - ll.y
                
                sendMove(xMove, y: yMove)

            }
            
            lastLocation = location
        
        }
        
    }


    var roomPeerID: MCPeerID?
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        roomPeerID = peerID
        
        println("invite from \(peerID)")
        
        invitationHandler(true, session)
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
        println("\(state.rawValue) = \(peerID)")
        
        println(session.connectedPeers)
    }
    
    


}

