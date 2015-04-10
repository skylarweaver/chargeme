//
//  VC_borrow.swift
//  chargeme
//
//  Created by Angela Liu on 3/29/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_borrow: UIViewController {
    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBAction func findLenderButton(sender: AnyObject)
        {
        // Create request class
            var object = PFObject(className: "Request")
            object.addObject(deviceTextField.text, forKey: "websiteUrl")
            object.addObject("Five", forKey: "websiteRating")
            object.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> Void in
                if (success != nil) {
                    NSLog("Object created with id: \(object.objectId)")
                } else {
                    NSLog("%@", error)
                }
                var user2 = PFUser.currentUser()
                if (user2 != nil){
                    println("EMAIL!")
                    println(user2.email)
                }
            }

            // save device and time duration to parse in that request object, along with user requesting
        //search for other users who have that charger in order of distance. Might want another function or class to do this?
        //
        
    }
}

