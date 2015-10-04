//
//  UserModel.swift
//  photos
//
//  Created by Jonathan Brennecke on 10/2/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

struct UserModel : Model  {
    let username: String
    let email: String
    let id: String
}

extension UserModel {
    func setUsername(newUsername: String) -> UserModel {
        return UserModel(username: newUsername, email: email, id: id)
    }
    
    func setEmail(newEmail: String) -> UserModel {
        return UserModel(username: username, email: newEmail, id: id)
    }
    
    func setId(newId: String) -> UserModel {
        return UserModel(username: username, email: email, id: newId)
    }
    
    func toArray() throws -> [String : AnyObject] {
        return [
            "username": username,
            "email": email,
            "id": id
        ]
    }
}
