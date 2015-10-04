//
//  UserViewActions.swift
//  photos
//
//  Created by Jonathan Brennecke on 10/3/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import Foundation

struct UserViewActions {
    
    static func loginUser(user: UserLoginModel, callback: ((user: UserModel) -> Void)?) throws {
        try Request("http://localhost:4000/api/users/login", method: .POST, data: user.toData()).send { response in
            if response.error != nil {
                print(response.error!)
            }
            else {
                do {
                    let resObject = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions(rawValue: 0))
                    if let res = resObject as? Dictionary<String, AnyObject> {
                        let user = UserModel(
                            username: res["username"] as! String,
                            email: res["email"] as! String,
                            id: res["_id"] as! String
                        )
                        callback?(user: user)
                    }
                }
                catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
}