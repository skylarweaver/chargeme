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
    
    @IBOutlet weak var ownedchargers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ownedchargers.dataSource = self
        ownedchargers.delegate = self
        NSLog(PFUser.currentUser().username)
        if PFUser.currentUser().objectForKey("chargersOwn") == nil {
            // First time on screen, initialize their charger array
            PFUser.currentUser().setValue([String](), forKey: "chargersOwn")
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
            // If the add charger viewcontroller passed back and set charger here to something not none, then we need to add it to our array saved on Parse
            PFUser.currentUser().addObject(charger, forKey: "chargersOwn")
            PFUser.currentUser().saveEventually()
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
        PFUser.currentUser().mutableArrayValueForKey("chargersOwn").removeObjectAtIndex(indexPath.item)
        PFUser.currentUser().saveEventually()
        ownedchargers.reloadData()
    }
    
    // ------------------------------------------------------

    


}

