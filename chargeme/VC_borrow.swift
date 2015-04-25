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
//    var chargers = [AnyObject]()
    //Also hardcoded in VC_Add_chargers
    var chargerarray = ["iPhone 4","iPhone 4S", "iPhone 5", "iPhone 5S", "iPhone 6", "iPhone 6S", "Old Macbook Pro", "Macbook Air", "New RMBP"]
    
    var request_type = "None"

    
    
    @IBAction func findLenderButton(sender: AnyObject){
            // Create request class
        if (selectedCharger != "") {
            var request = PFObject(className: "Request")
            request.setObject(selectedCharger, forKey: "chargerType")
            request.setObject(requester, forKey: "requester")
            request.setObject(sliderValue, forKey: "minutesRequested")
            //add request.setObject(LOCATION, forKey: "requesterLocation")
            request.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> Void in
                if (success != nil) {
                    NSLog("Object created with id: \(request.objectId)")
                } else {
                    NSLog("SHIT")
                    NSLog("%@", error)
                }
                }
                request_type = selectedCharger
            Utils.findMatchingLenders(request);
        }else{
            var noChargerAlert = UIAlertController(title: "Select a Charger", message: "Please chose a charger you would like to request.", preferredStyle: UIAlertControllerStyle.Alert)
            noChargerAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(noChargerAlert, animated: true, completion: nil)
        }
            // save device and time duration to parse in that request object, along with user requesting

    }
    @IBAction func valueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        sliderLabel.text = "\(currentValue) Minutes"
        sliderValue = Int(sender.value)
        self.slider.minimumValue = 1;

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
        self.slider.value = (15);
        sliderLabel.text = "\(15) Minutes";
        sliderValue = 15;
    }
    // We set the number of rows to be the length of the Parse charger array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargerarray.count
    }
    
    // Reaches out to Parse and loads in a users chargers with a callback, and then reloads table
    func loadChargerDataFromParse() {
//        var users_chargers_relationship = PFUser.currentUser().relationForKey("chargers")
//        users_chargers_relationship.query().findObjectsInBackgroundWithBlock {
//            (response_objects: [AnyObject]!, error: NSError!) -> Void in
//            if error != nil { NSLog("Could not load chargers from parse") }
//            else {
//                self.chargers = response_objects
//                // We need to reload the table view now that we have the user's chargers
//                self.chargerTableView.reloadData()
//            }
//        }
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = chargerarray[indexPath.item]
        cell.addSubview(label)
        return cell
        
    }
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Touch handler: Tapping a charger removes it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var chargerstring = self.chargerarray[indexPath.item]
        self.selectedCharger = chargerstring
    }
    
    // ------------------------------------------------------
    // SEGUE SHIT
    // ------------------------------------------------------
    // Do stuff before segue, in this case clicking the 'add charger' button will send a segue (the back button does not send a segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         NSLog("PREPARE FOR SEGUE");
        if request_type != "None" {
            let destinationVC = segue.destinationViewController as VC_listLenders
            destinationVC.request_type = request_type
        }
        //PFUser.currentUser().mutableArrayValueForKey("chargersOwn").removeObjectAtIndex(indexPath.item)
//        PFUser.currentUser().saveEventually()
//        chargerTableView.reloadData()
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

