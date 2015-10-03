//
//  LoginModel.swift
//  photos
//
//  Created by Jonathan Brennecke on 10/3/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

struct UserLoginModel : Model  {
    let username: String?
    let password: String?
}

extension UserLoginModel {
    func setUsername(newUsername: String) -> UserLoginModel {
        return UserLoginModel(username: newUsername, password: password)
    }
    
    func setPassword(newPassword: String) -> UserLoginModel{
        return UserLoginModel(username: username, password: newPassword)
    }
    
    func toArray() throws -> [String : AnyObject] {
        return [
            "username": username!,
            "password": password!
        ]
    }
}

