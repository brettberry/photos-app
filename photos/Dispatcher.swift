//
//  Dispatcher.swift
//  photos
//
//  Created by Brett Berry on 9/27/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import UIKit


class Dispatcher {
    
    class func sendImage(image: UIImage) {
        let url = NSURL(string: "http://localhost:4000/api/posts")
        let request = NSMutableURLRequest(URL: url!)
        let boundary = generateBoundaryString()
        
        request.HTTPMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = UIImagePNGRepresentation(image)
        let body = NSMutableData()
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"file\";\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(data!)
        body.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        request.HTTPBody = body
        return sendRequest(request)
        
    }
    
    class func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }

}
