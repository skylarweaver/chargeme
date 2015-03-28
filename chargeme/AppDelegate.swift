//
//  AppDelegate.swift
//  chargeme
//
//  Created by Paul Okuda on 3/4/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        println("HELLO")

        Parse.setApplicationId("I7unmJdF7zHeB0erTmiZG1N7VMx7yU27FvjCvHTv", clientKey: "VdtIQrnF9j1ybeiiPfhN0mHm7vYBVSNETCqJnbO5")
        
        //initialize facebook
        PFFacebookUtils.initializeFacebook()
        
//        var currentUser = PFUser.currentUser()
//        if currentUser != nil {
//            // Do stuff with the user
//        } else {
//            // Show the signup or login screen
//        }
        
//                var user = PFUser()
//                user.username = "myUsername"
//                user.password = "myPassword"
//                user.email = "email@example.com"
//                user.signUpInBackgroundWithBlock {
//                    (succeeded: Bool!, error: NSError!) -> Void in
//                    if error == nil {
//                        // Hooray! Let them use the app now.
//                    } else {
//                        println("SHITTTT")
//                        // Show the errorString somewhere and let the user try again.
//                    }
//                }
        var user1 = PFUser.currentUser()
        println (user1.email)
        
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
        
        }
        
        //for parse facebook login
        Utils.logInWithFacebook()
        Utils.obtainUserNameAndFbId()
//
//        let permissions = ["user_about_me", "user_relationships", "user_birthday", "user_location"  ]
//        PFFacebookUtils.logInWithPermissions(permissions, {
//            (user: PFUser!, error: NSError!) -> Void in
//            if let user = user {
//                if user.isNew {
//                    println("User signed up and logged in through Facebook!")
//                } else {
//                    println("User logged in through Facebook!")
//                }
//            } else {
//                println("Uh oh. The user cancelled the Facebook login.")
//            }
//        })
        
        
//        // [Optional] Power your app with Local Datastore. For more info, go to
//        // https://parse.com/docs/ios_guide#localdatastore/iOS
//        [Parse enableLocalDatastore];
//        
//        // Initialize Parse.
//        [Parse setApplicationId:@"I7unmJdF7zHeB0erTmiZG1N7VMx7yU27FvjCvHTv"
//        clientKey:@"VdtIQrnF9j1ybeiiPfhN0mHm7vYBVSNETCqJnbO5"];
//        
//        // [Optional] Track statistics around application opens.
//        [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
//        
//        // ...

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

