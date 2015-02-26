//
//  ViewController.swift
//  Bumper
//
//  Created by Michael McChesney on 2/10/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class BallView: UIView {
    
    var displayName: String?
    
}

class ViewController: UIViewController, MCSessionDelegate, MCNearbyServiceBrowserDelegate {
    
    var session: MCSession!
    var myPeerID: MCPeerID!
    var browser: MCNearbyServiceBrowser!
    
    let serviceType = "b2"
    
    var allBallViews: [BallView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myPeerID = MCPeerID(displayName: "Room")
        
        session = MCSession(peer: myPeerID)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        browser.delegate = self
        
        browser.startBrowsingForPeers()
        
    }
    
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        
        println("found \(peerID)")
        
        browser.invitePeer(peerID, toSession: session, withContext: nil, timeout: 10)
        
        if let size = info?["size"] as? String {
            
            let s = CGFloat(size.toInt()!)
            
            var ballView = BallView(frame: CGRectMake(0, 0, s, s))
            
            ballView.displayName = peerID.displayName
            
            ballView.layer.cornerRadius = s / 2
            ballView.center = view.center
            
            allBallViews.append(ballView)
            
            view.addSubview(ballView)
            
            if let colorR = info?["colorR"] as? NSString {
                
                let r = CGFloat(colorR.floatValue)
                let g = CGFloat((info!["colorB"] as NSString).floatValue)
                let b = CGFloat((info!["colorG"] as NSString).floatValue)
                
                ballView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
                
            }
            
        }
        
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        println("lost \(peerID)")
    }

    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
        let moveInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as [String:CGFloat]
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            for ballView in self.allBallViews {
                
                if ballView.displayName == peerID.displayName {
                    
                    ballView.center.x += moveInfo["x"]!
                    ballView.center.y += moveInfo["y"]!
                    
                }
            }
            
        })
        
        println("\(moveInfo) from \(peerID)")
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
    }
    



}

