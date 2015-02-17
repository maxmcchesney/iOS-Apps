//
//  API.swift
//  RailsRequest
//
//  Created by Michael McChesney on 2/17/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import Foundation

let API_URL = "https://pure-anchorage-3070.herokuapp.com/"

class APIRequest {

    
    class func requestWithOptions(options: [String:AnyObject], andCompletion completion: (responseInfo: [String:AnyObject]) -> ()) {
        
        var url = NSURL(string: API_URL + (options["endpoint"] as String))
        
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = options["method"] as String

        ///// BODY
        
        let bodyInfo = options["body"] as [String:AnyObject]
        
        let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: .allZeros, error: nil)
        
        let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
        
        let postLength = "\(jsonString!.length)"
        
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = postData
        
        ///// END BODY - now that it is setup, send the request
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if error == nil {
                // do something with data
                
                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as [String:AnyObject]

                completion(responseInfo: json)
                
            } else {
                println(error)
            }
   
        }
        
    }
    
}

private let _currentUser = User()

class User {
    
    var token: String? {
        didSet {
            // save the token when it's set
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
        }
    }
    
    init() {    // this fixes "no initializers" issue when creating the singleton. could do this or base class off NSObject.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? String
        
    }
    
    class func currentUser() -> User { return _currentUser }
    
    func getUserToken() {
        
        let options: [String:AnyObject] = [
        
            "endpoint" : "users",
            "method" : "POST",
            "body" : [
            
                "user" : [ "email" : "max@test.com", "password" : "password" ]
            
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println(responseInfo)
            
            let dataInfo = responseInfo["data"] as [String:String]
            
            self.token = dataInfo["auth_token"]
            
        })
    }
    
}