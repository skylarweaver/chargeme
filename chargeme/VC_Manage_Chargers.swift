//
//  VC_Manage_Chargers.swift
//  chargeme
//
//  Created by Angela Liu on 3/29/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_Manage_Chargers: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var chargers = [String]() // Swift mutable array of strings
    // charger: String of the most recently selected charger from the other view
    var charger = "none" // String of most recently added charger, is passed back from the add charger controller
    
    @IBOutlet weak var ownedchargers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ownedchargers.dataSource = self
        ownedchargers.delegate = self
        NSLog(PFUser.currentUser().username)
        if PFUser.currentUser() == nil {
            println("NO SAVED CHARGERS")
        }
        else {
            println("SOME SAVED")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // SEGUES
    // ------------------------------------------------------
    // This is a exit segue 'response' that is called when a button in another view (the addcharger view) is clicked
    @IBAction func addCharger(segue:UIStoryboardSegue) {
        NSLog("Recieved SEGUE")
        if charger != "none" {
            // If the add charger viewcontroller passed back and set charger here to something not none, then we need to add it to our array
            chargers.append(charger)
            NSLog(charger)
            println(chargers)
            // Reset back to none in prep for next added charger
            charger = "none"
        }
    }
    
    // Table population
    // ------------------------------------------------------
    
    // Dynamically populating the table view with chargers in charger array
    // We set the number of rows to be the length of the charger array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargers.count
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = chargers[indexPath.item]
        cell.addSubview(label)
        return cell
    }
    
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Touch handler: Tapping a charger removes it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chargers.removeAtIndex(indexPath.item)
        ownedchargers.reloadData()
    }

    


}

