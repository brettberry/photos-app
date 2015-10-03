//
//  APIService.swift
//  photos
//
//  Created by Jonathan Brennecke on 9/28/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation
import UIKit



struct Response {
    let data: NSData?
    let response: NSURLResponse?
    let error: NSError?
}

enum HttpMethod : String {
    case POST = "POST"
    case GET = "GET"
}

class Request {

    typealias callbackType = (response: Response) -> Void
    static let boundary = "Boundary-\(NSUUID().UUIDString)"
    let request: NSURLRequest?
    
    init(_ url: String) {
        self.request = NSURLRequest(URL: NSURL(string: url)!)
    }

    init(_ request: NSURLRequest) {
        self.request = request
    }
    
    init(_ url: String, method: HttpMethod, data: NSData) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = method.rawValue
        request.HTTPBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        self.request = request
    }

    init?(_ url: String, method: HttpMethod, data: [String: AnyObject]) {
        do {
            let request = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = method.rawValue
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions(rawValue: 0))
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            self.request = request
        }
        catch {
            self.request = nil
            return nil
        }
    }

    init(_ url: String, method: HttpMethod, image: UIImage) {
         let request = NSMutableURLRequest(URL: NSURL(string: url)!)
         request.HTTPMethod = method.rawValue
         request.setValue("multipart/form-data; boundary=\(Request.boundary)", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
         request.HTTPBody = Request.createHttpBodyWithImage(image)
         self.request = request
     }


    func send(callback: callbackType?) {
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request!, completionHandler: {
        (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            callback?(response: Response(
                data: data,
                response: response,
                error: error
            ))
        })
        dataTask.resume()
    }

     class func createHttpBodyWithImage(image: UIImage) -> NSData {
         let data = UIImagePNGRepresentation(image)
         let body = NSMutableData()
         body.appendData("--\(Request.boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
         body.appendData("Content-Disposition: form-data; name=\"file\";\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
         body.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
         body.appendData(data!)
         body.appendData("\r\n--\(Request.boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
         return body as NSData
     }
}
