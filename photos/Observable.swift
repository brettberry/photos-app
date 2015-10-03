//
//  Observable.swift
//  photos
//
//  Created by Jonathan Brennecke on 10/3/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

protocol Observer: class {
    func recieve(notification: NSNotification)
}

class Observable {
    
    static let sharedNotificationCenter = NSNotificationCenter.defaultCenter()
    
    func subscribe(observer: Observer) {
        Observable.sharedNotificationCenter.addObserver(observer, selector: "recieve:", name: nil, object: self)
    }
    
    func publish(eventName: String, object: AnyObject) {
        Observable.sharedNotificationCenter.postNotificationName(eventName, object: object)
    }
    
    deinit {
        // TODO use "removeObserver" to remove all connected observers to prevent memory leaks
    }
}