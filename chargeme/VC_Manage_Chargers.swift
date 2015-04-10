//
//  VC_Manage_Chargers.swift
//  chargeme
//
//  Created by Angela Liu on 3/29/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_Manage_Chargers: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // charger: String of the most recently added/selected charger, variable passed back from the add_charger controller
    var charger = "none"
    // chargers: Array of charger objs loaded from parse
    var chargers = [AnyObject]()
    
    @IBOutlet weak var ownedchargers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ownedchargers.dataSource = self
        ownedchargers.delegate = self
        NSLog(PFUser.currentUser().username)
        
        // First time on screen, initialize their charger array
        if PFUser.currentUser().objectForKey("chargersOwn") == nil {
            PFUser.currentUser().setValue([PFObject](), forKey: "chargersOwn")
            PFUser.currentUser().saveEventually()
        } else { // Not first time, lets load in the chargers user owns
            var users_chargers_relationship = PFUser.currentUser().relationForKey("chargers")
            users_chargers_relationship.query().findObjectsInBackgroundWithBlock {
                (response_objects: [AnyObject]!, error: NSError!) -> Void in
                if error != nil { NSLog("Could not load chargers from parse") }
                else { self.chargers = response_objects }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ------------------------------------------------------
    // SEGUES
    // ------------------------------------------------------
    // This is a exit segue 'response' that is called when a button in another view (the addcharger view) is clicked
    @IBAction func addCharger(segue:UIStoryboardSegue) {
        // NSLog("Recieved SEGUE")
        if charger != "none" {
            
            // Create a charger obj and associate it with the logged in user
            var newcharger = PFObject(className:"Charger")
            newcharger["type"] = charger
            newcharger["isAvailable"] = false
            var chargers_user_relationship = newcharger.relationForKey("user")
            chargers_user_relationship.addObject(PFUser.currentUser())
            
            // We save the newcharger AND then run a callback that associates the charger with a user
            // This is necessary b/c otherwise the user might fail to associate b/c charger hasn't saved yet
            newcharger.saveInBackgroundWithBlock({ (succeeded: Bool!, error: NSError!) -> Void in
                // The callback
                var users_chargers_relationship = PFUser.currentUser().relationForKey("chargers")
                users_chargers_relationship.addObject(newcharger)
                PFUser.currentUser().saveInBackground()
            })
        
            // Reset charger variable back to none to prep for next added charger
            charger = "none"
        }
    }
    
    
    // ------------------------------------------------------
    // Table population / Removing chargers
    // ------------------------------------------------------
    // Dynamically populating the table view with chargers in charger array from Parse
    
    // We set the number of rows to be the length of the Parse charger array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PFUser.currentUser().mutableArrayValueForKey("chargersOwn").count
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        
        println(self.chargers[indexPath.item])
        
        var chargertype = PFUser.currentUser().mutableArrayValueForKey("chargersOwn")[indexPath.item]["type"]
        label.text = chargertype as? String
        
        cell.addSubview(label)
        return cell
    }
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Touch handler: Tapping a charger removes it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        PFUser.currentUser().mutableArrayValueForKey("chargersOwn").removeObjectAtIndex(indexPath.item)
        PFUser.currentUser().saveEventually()
        ownedchargers.reloadData()
    }
    
    // ------------------------------------------------------

    


}

