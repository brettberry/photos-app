//
//  CurrentUserStore.swift
//  photos
//
//  Created by Jonathan Brennecke on 10/3/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

enum CurrentUserStoreEvents: String {
    case RecieveUpdatedUser = "RECIEVE_UPDATED_USER"
    case RecieveNewUser = "RECIEVE_NEW_USER"
}

class CurrentUserStore: Store {
    
    static let sharedCurrentUserStore = CurrentUserStore()
    
    var currentUser: UserModel?
    
    func setCurrentUser(user: UserModel) {
        currentUser = user
        publish(CurrentUserStoreEvents.RecieveNewUser.rawValue, object: self)
    }
}