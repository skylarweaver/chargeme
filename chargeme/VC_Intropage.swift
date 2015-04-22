//
//  VC_Intropage.swift
//  chargeme
//
//  Created by Angela Liu on 4/12/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_Intropage: UIViewController {
    
    @IBOutlet weak var fb_loginbutton: UIButton!
    //User clicks Login button, login via Facebook, then goes to homepage
    @IBAction func facebookLogin(sender: AnyObject) {
        Utils.logInWithFacebook()
        self.performSegueWithIdentifier("segue_homepage", sender: self)
    }

    // Check user logged in - if logged in, automatically push to next page (home)
    override func viewDidLoad() {
        if Utils.loggedIn() {
            println("Logged in")
            self.performSegueWithIdentifier("segue_homepage", sender: self)
        } else {
            println("Loged out")
            super.viewDidLoad()
        }
    }

    
}
