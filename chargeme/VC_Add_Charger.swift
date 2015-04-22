//
//  VC_Add_Charger.swift
//  chargeme
//
//  Created by Angela Liu on 3/29/15.
//  Copyright (c) 2015 Paul Okuda. All rights reserved.
//

import UIKit

class VC_Add_Charger: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    // chargerarray: Possible chargers to add, hardcoded for now
    var chargerarray = ["iPhone 4","iPhone 4S", "iPhone 5", "iPhone 5S", "iPhone 6", "iPhone 6S", "Old Macbook Pro", "Macbook Air", "New RMBP"]
    //array now moved to Utils file
    var selectedCharger = "none"
    
    @IBOutlet weak var chargertable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chargertable.dataSource = self
        chargertable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ------------------------------------------------------
    // Table population of charger array
    // ------------------------------------------------------
    // Dynamically populating the table view with chargers in charger array
    
    // We set the number of rows to be the length of the charger array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargerarray.count
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
    
    // Touch handler for each table cell being tapped
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog(chargerarray[indexPath.item])
        selectedCharger = chargerarray[indexPath.item]
    }
    
    // ------------------------------------------------------
    // SEGUE SHIT
    // ------------------------------------------------------
    // Do stuff before segue, in this case clicking the 'add charger' button will send a segue (the back button does not send a segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // NSLog("PREPARE FOR SEGUE");
        if selectedCharger != "none" {
            // Set the destination, which is our homepage viewcontroller, pass it back name of selected charger
            let destinationVC = segue.destinationViewController as VC_Manage_Chargers
            destinationVC.charger = selectedCharger
        }
    }

}

