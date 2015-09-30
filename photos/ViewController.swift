//
//  ViewController.swift
//  photos
//
//  Created by Brett Berry on 9/27/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var sendImageButton: UIButton!
    var imagePicker = UIImagePickerController()
    
    
    @IBAction func selectImageButtonClicked(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .SavedPhotosAlbum
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func sendImageButtonClicked(sender: AnyObject) {
        Request("http://localhost:3000/api/media", method: .POST, image: imageView.image!)
            .send({ response in
                if response.error != nil {
                    print(response.error)
                }
                else {
                    let str = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                    print(str)
                }
            })
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
    }
}

