//
//  VC_borrow.swift
//  chargeme
//
//  Created by Angela Liu on 3/29/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_borrow: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var chargerTableView: UITableView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    var selectedCharger = ""
    var timeRequested = 1
    var requester = PFUser.currentUser().objectId
    var sliderValue = 15
    // charger: String of the most recently added/selected charger, variable passed back from the add_charger controller
    var charger = "none"
    // chargers: Array of charger objs loaded from parse
    var chargers = [AnyObject]()
    
    
    @IBAction func findLenderButton(sender: AnyObject)
        {
        // Create request class
            var request = PFObject(className: "Request")
            request.setObject(selectedCharger, forKey: "chargerId")
            request.setObject(requester, forKey: "requester")
            request.setObject(sliderValue, forKey: "minutesRequested")
            //add request.setObject(LOCATION, forKey: "requesterLocation")

//            NSLog(selectedCharger)
            NSLog(requester)
            request.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> Void in
                if (success != nil) {
                    NSLog("Object created with id: \(request.objectId)")
                } else {
                    NSLog("SHIT")
                    NSLog("%@", error)
                }
            }

            // save device and time duration to parse in that request object, along with user requesting
        //search for other users who have that charger in order of distance. Might want another function or class to do this?
        //fdfdf
    }
    @IBAction func valueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        sliderLabel.text = "\(currentValue)"
        sliderValue = Int(sender.value)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        chargerTableView.dataSource = self
        chargerTableView.delegate = self
        NSLog(PFUser.currentUser().username)
        if PFUser.currentUser().objectForKey("chargersOwn") == nil {
            PFUser.currentUser().setValue([PFObject](), forKey: "chargersOwn")
            PFUser.currentUser().saveEventually()
        } else { // Not first time, lets load in the chargers user owns
            self.loadChargerDataFromParse()
        }
    }
    // We set the number of rows to be the length of the Parse charger array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PFUser.currentUser().mutableArrayValueForKey("chargersOwn").count
    }
    
    // Reaches out to Parse and loads in a users chargers with a callback, and then reloads table
    func loadChargerDataFromParse() {
        var users_chargers_relationship = PFUser.currentUser().relationForKey("chargers")
        users_chargers_relationship.query().findObjectsInBackgroundWithBlock {
            (response_objects: [AnyObject]!, error: NSError!) -> Void in
            if error != nil { NSLog("Could not load chargers from parse") }
            else {
                self.chargers = response_objects
                // We need to reload the table view now that we have the user's chargers
                self.chargerTableView.reloadData()
            }
        }
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        if self.chargers.count > 0 {
            var chargertype = self.chargers[indexPath.item]["type"]
            label.text = chargertype as? String

        }
        else{
            label.text = ""
        }
        cell.addSubview(label)
        return cell
    }
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Touch handler: Tapping a charger removes it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var chargerstring = self.chargers[indexPath.item]["type"]
        var query = PFQuery(className: "Charger")
        query.whereKey("user", equalTo:PFUser.currentUser())
        query.whereKey("type", equalTo: chargerstring)
        
        //find charger then save object
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Query find suceeded, do something with the found objects
                if let objects = objects as? [PFObject] {
                    self.selectedCharger = objects[0].objectId
//                    self.loadChargerDataFromParse()
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        
        //PFUser.currentUser().mutableArrayValueForKey("chargersOwn").removeObjectAtIndex(indexPath.item)
//        PFUser.currentUser().saveEventually()
//        chargerTableView.reloadData()
    }
}

