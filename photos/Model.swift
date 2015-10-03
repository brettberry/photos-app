//
//  Model.swift
//  photos
///Users/jon/Projects/photos-app/photos/Model.swift
//  Created by Jonathan Brennecke on 10/3/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

protocol Model {
    func toArray() throws -> [String: AnyObject]
    func toData() throws -> NSData
    func toJson() throws -> NSString?
}

extension Model {
    func toData() throws -> NSData {
        return try NSJSONSerialization.dataWithJSONObject(toArray(), options: NSJSONWritingOptions(rawValue: 0))
    }
    
    func toJson() throws -> NSString? {
        return try NSString(data: toData(), encoding: NSUTF8StringEncoding)
    }
}