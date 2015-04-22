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
    
    @IBAction func findLenderButton(sender: AnyObject) {
        // Create request class
        // save device and time duration to parse in that request object, along with user requesting
        //search for other users who have that charger in order of distance. Might want another function or class to do this?
        //
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        NSLog("Please");
//        super.viewWillDisappear(animated)
//        if (self.isMovingFromParentViewController()){
//            NSLog("AHHH");
//        }
//    }
    
    // Logout user when back button is pressed and user goes back to intro/homepage
//    override func willMoveToParentViewController(parent: UIViewController?) {
//        NSLog("PRessed back button")
////        PFUser.logOut()
//    }

}

