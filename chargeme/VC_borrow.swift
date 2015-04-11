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
    @IBAction func findLenderButton(sender: AnyObject)
        {
        // Create request class
            var request = PFObject(className: "Request")
            request.setObject(selectedCharger, forKey: "chargerId")
            request.setObject(requester, forKey: "requester")
            request.setObject(sliderValue, forKey: "minutesRequested")
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
            // First time on screen, initialize their charger array
            PFUser.currentUser().setValue([String](), forKey: "chargersOwn")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PFUser.currentUser().mutableArrayValueForKey("chargersOwn").count
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = PFUser.currentUser().mutableArrayValueForKey("chargersOwn")[indexPath.item] as? String
        cell.addSubview(label)
        return cell
    }
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Touch handler: Tapping a charger removes it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCharger = "fish"
        
        //PFUser.currentUser().mutableArrayValueForKey("chargersOwn").removeObjectAtIndex(indexPath.item)
//        PFUser.currentUser().saveEventually()
//        chargerTableView.reloadData()
    }
}

