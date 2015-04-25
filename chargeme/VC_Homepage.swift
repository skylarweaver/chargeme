//
//  ViewController.swift
//  chargeme
//
//  Created by Paul Okuda on 3/4/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_Homepage: UIViewController {
    
    @IBOutlet weak var sendnotif: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var textDescription: UITextView!
    
    @IBOutlet weak var borrowbutton: UIButton!
    @IBOutlet weak var logoutbutton: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    
    // User clicks logout button
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut();
        borrowbutton.hidden = true
        loginbutton.hidden = false
        logoutbutton.hidden = true
    }
    
    //User clicks Login button
    @IBAction func facebookLogin(sender: AnyObject) {
        Utils.logInWithFacebook()
        loginbutton.hidden = true
        logoutbutton.hidden = false
        borrowbutton.hidden = false
    }
   
    override func viewDidLoad() {
        if Utils.loggedIn() {
            loginbutton.hidden = true
            logoutbutton.hidden = false
            borrowbutton.hidden = false
            NSLog("Logged in")
            println("Logged in")
            self.performSegueWithIdentifier("segue_borrow", sender: self)
        } else {
            loginbutton.hidden = false
            borrowbutton.hidden = true
            logoutbutton.hidden = true
            println("Logged out")
            super.viewDidLoad()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Notification testing: Touching the button immediately sends the notification which is then immediately responded in AppDelegate (didReceiveLocalNotification)
    @IBAction func touch_sendNotif(sender: AnyObject) {
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertAction = "Hi, I am a notification"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        NSLog("Touched")
    }
    
    // Set title to logout
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = nil
        borrowbutton.hidden = false
        logoutbutton.hidden = false
        loginbutton.hidden = true
        if segue.identifier == "segue_borrow" {
            navigationItem.title = "Logout";
        }
    }
    


}

