
//
//  FourSquareRequest.swift
//  MaxMaps
//
//  Created by Michael McChesney on 2/2/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit
import CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "BLC1CZXPUGG52VVDSNPRBI1PQTXJPLMRMXHNL0GPWVXN1COR"
let CLIENT_SECRET = "2TLJZT04LD4IIGNW30U3N4XP2XVAFSXB5MMRGDCIKURQMA3P"

class FourSquareRequest: NSObject {
   
    class func requestVenuesWithLocation(location: CLLocation) -> [AnyObject] {
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        println(requestString)
        
        if let url = NSURL(string: requestString) {
            let request = NSURLRequest(URL: url)
        
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    
                    let venues = responseInfo["venues"] as [AnyObject]
                    
                    return venues
                    
                }
                
                
                
            }
            
            
        }
        
        
        
        //TODO: ADD IMPLEMENTATION
        return []
    }
    
    
}
