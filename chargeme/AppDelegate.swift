//
//  AppDelegate.swift
//  chargeme
//
//  Created by Paul Okuda on 3/4/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

// The AppDelegate is 'root' code of our application that is 'present' in any screen, and also handles events like recieving notifactions, managing users, and more

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        Parse.setApplicationId("I7unmJdF7zHeB0erTmiZG1N7VMx7yU27FvjCvHTv", clientKey: "VdtIQrnF9j1ybeiiPfhN0mHm7vYBVSNETCqJnbO5")
        //initialize facebook
        PFFacebookUtils.initializeFacebook()
//        var user1 = PFUser.currentUser()
//        println (user1.email)
        //Tests to see if parse is working
        NSLog("HELLO")
        var object = PFObject(className: "testDataClass")
        object.addObject("iOSBlog", forKey: "websiteUrl")
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
        
        // ===================================
        // Notification Setup code: Will ask user if they want to allow notifications from our app, and sets up what notifications we respond to
        
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
        

        //WHAT TO SHOW ON HOMEPAGE IF USER IS LOGGED IN
        
    return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }
    
    //for parse facebook login
    func applicationDidBecomeActive(application: UIApplication) {
        Utils.obtainUserNameAndFbId()
        NSLog("Here1")
        
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    
    }

    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
        
//        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
//        return wasHandled
        
        return true;
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

