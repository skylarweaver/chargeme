//
//  Utils.swift
//  chargeme
//
//  Created by Skylar Weaver on 3/21/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import Foundation

class Utils {
    class func notLoggedIn() -> Bool {
        let user = PFUser.currentUser()
        // here I assume that a user must be linked to Facebook
        return user == nil || !PFFacebookUtils.isLinkedWithUser(user)
    }
    
    class func loggedIn() -> Bool {
        return !notLoggedIn()
    }
    
    
    class func logInWithFacebook() {
            PFFacebookUtils.logInWithPermissions(["public_profile", "email", "user_friends"]) {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("The user cancelled the Facebook login (user is nil)")
            }
            else {
                NSLog("The user successfully logged in with Facebook (user is NOT nil)")
                // HERE I SET AN ACL TO THE INSTALLATION
                if let installation = PFInstallation.currentInstallation() {
                    let acl = PFACL(user: PFUser.currentUser()) // Only user can write
                    acl.setPublicReadAccess(true) // Everybody can read
                    acl.setWriteAccess(true, forRoleWithName: "Admin") // Also Admins can write
                    installation.ACL = acl
                    installation.saveEventually()
                }
                // THEN I GET THE USERNAME AND fbId
                Utils.obtainUserNameAndFbId()
            }
        }
    }
    
    
    class func obtainUserNameAndFbId() {
        NSLog("Here 2")
        if notLoggedIn() {
            NSLog("NOT LOGGED IN")
            return
        }
        let user = PFUser.currentUser() // Won't be nil because is logged in
        // RETURN IF WE ALREADY HAVE A USERNAME AND FBID (note that we check the fbId because Parse automatically fills in the username with random numbers)
        if let fbId = user["fbId"] as? String {
            if !fbId.isEmpty {
                NSLog("we already have a username and fbId -> return")
                return
            }
        }
        // REQUEST TO FACEBOOK
        NSLog("performing request to FB for username and IDF...")
        if let session = PFFacebookUtils.session() {
            if session.isOpen {
                println("session is open")
                FBRequestConnection.startForMeWithCompletionHandler({ (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    NSLog("done me request")
                    if error != nil {
                        println("facebook me request - error is not nil :(")
                    } else {
                        println("facebook me request - error is nil :)")
                        println(result)
                        // You have 2 ways to access the result:
                        // 1)
                        println(result["name"])
                        println(result["id"])
                        // 2)
                        NSLog(result.name)
                        println(result.objectID)
                        // Save to Parse:
                        PFUser.currentUser().username = result.name
                        PFUser.currentUser().setValue(result.objectID, forKey: "fbId")
                        PFUser.currentUser().setValue(result.email, forKey: "email")
                        PFUser.currentUser().saveEventually() // Always use saveEventually if you want to be sure that the save will succeed
                    }
                })
            }
        }
    }
    
    
    // Notification Setup code (Angela): Will ask user if they want to allow notifications from our app, and sets up what notifications we respond to
    class func setupNotifications() {
        // Notification actions
        var firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "First Action"
        // This action activates in background of app
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = true
        firstAction.authenticationRequired = false // authentication would be required in cases where said notification wants to delete data, etc
        
        // Notifiation categories
        // You can organize your actions that are displayed in different contexts (eg default = all contexts, or only on lock screen, or only as a banner, etc. Here there's only one action so I'll just make it default)
        var firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        let defaultActions:NSArray = [firstAction]
        firstCategory.setActions(defaultActions, forContext: UIUserNotificationActionContext.Default)
        
        // NS set of all our categories (only one in our case)
        let categories:NSSet = NSSet(objects: firstCategory)
        
        // Types of notification types we support
        let types:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge
        // Define settings for notifications
        let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: categories)
        
        // Register notifications of our app with our settings
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)

        
    }
    
}