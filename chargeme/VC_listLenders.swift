//
//  VC_listLenders.swift
//  chargeme
//
//  Created by Skylar Weaver on 4/22/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import Foundation
import UIKit

class VC_listLenders: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lenderList: UITableView!
    var request_type = "";
    
    override func viewDidLoad() {
        println("HALY");
    }
    
    func loadMatchingUsersFromParse() {
        var users_chargers_relationship: [PFRelation] = []
        var matchingLenders: [PFObject] = []
        println("Searching for matching lenders");
        var query = PFQuery(className: "Charger")
        query.whereKey("type", equalTo: request.objectForKey("chargerType"))
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Query find suceeded, do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object: PFObject in objects {
                        //                      println("IN HERE")
                        var charger_user_relation = object.relationForKey("user")
                        var userQuery = charger_user_relation.query()
                        //                        userQuery.findObjectsInBackgroundWithBlock() {
                        //                            (objects1: [AnyObject]!, error: NSError!) -> Void in
                        //                            if error == nil {
                        userQuery.findObjectsInBackgroundWithBlock {
                            (objects1: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil {
                                let matchingLenders = objects1
                                // Query find suceeded, do something with the found objects
                                if let objects1 = objects1 as? [PFObject] {
                                    println(objects1);
                                    println("doing this");
                                }
                            } else {
                                // Log details of the failure
                                println("Error: \(error) \(error.userInfo!)")
                            }
                        }
                    };
                    println(matchingLenders);
                    println("IN HERE");
                    //                    users_chargers_relationship.query().findObjectsInBackgroundWithBlock {
                    //                        (response_objects: [AnyObject]!, error: NSError!) -> Void in
                    //                        if error != nil { NSLog("Could not load chargers from parse") }
                    //                        else {
                    //                            self.chargers = response_objects
                    //                            // We need to reload the table view now that we have the user's chargers
                    //                            self.ownedchargers.reloadData()
                    //                        }
                    //                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        //        notifyEachMatchingLender(matchingLenders);

        
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return Utils.findMatchingLenders(<#request: PFObject#>);
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
                let cell = UITableViewCell()
        return cell
        
    }
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Touch handler: Tapping a charger removes it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}

