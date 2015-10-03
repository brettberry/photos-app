//
//  FeedViewController.swift
//  photos
//
//  Created by Jonathan Brennecke on 10/3/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

import UIKit

class FeedViewController: UIViewController, Observer {
    
    let currentUserStore = CurrentUserStore.sharedCurrentUserStore
    var currentUser: UserModel?
    
    override func viewDidLoad() {
        currentUserStore.subscribe(self)
        super.viewDidLoad()
    }
    
    func recieve(notification: NSNotification) {
        currentUser = currentUserStore.currentUser
        print(currentUser)
    }
    
}