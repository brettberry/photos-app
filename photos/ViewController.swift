//
//  ViewController.swift
//  photos
//
//  Created by Brett Berry on 9/27/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var user = UserLoginModel(username: nil, password: nil)
 
    @IBAction func handleLoginButtonClick(sender: AnyObject) {
        if let username = usernameTextField.text, password = passwordTextField.text {
            do {
                user = UserLoginModel(username: username, password: password)
                try UserViewActions.loginUser(user) { user in
                    
                    // set the current user
                    CurrentUserStore.sharedCurrentUserStore.setCurrentUser(user)
                    
                    // transition to the logged in view
                    self.performSegueWithIdentifier("feedViewSeque", sender: self)
                }
            }
            catch let error as NSError {
                print(error)
            }
        }
    }
    
    @IBAction func handleSetUsernameField(sender: AnyObject) {
        if let username = usernameTextField.text {
            user = user.setUsername(username)
        }
    }
    
    @IBAction func handleSetPasswordField(sender: AnyObject) {
        if let password = passwordTextField.text {
            user = user.setPassword(password)
        }
    }
}

