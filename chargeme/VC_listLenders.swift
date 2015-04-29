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
    @IBOutlet weak  var lenderList: UITableView!
    var request_type = "";
  
    override func viewDidLoad() {
        super.viewDidLoad();
        lenderList.dataSource = self;
        lenderList.delegate = self;
        println("HALY");
    }
    
    func reloadLenderData(){
        println("UEAJ");
        self.lenderList.reloadData();
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (Utils.matchingLenders.count > 0){
            println("printing lenders count");
            println(Utils.matchingLenders.count);
            print (Utils.matchingLenders);
            return Utils.matchingLenders.count;
        }
        else{
            println("I AM IN HERE");
            return 7;
        }
    }
    
    // Now we're inserting a label into each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        println("- - - -- - - - - - - - - - - - -");
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        if (Utils.matchingLenders.count > 0){
            label.text = Utils.matchingLenders[indexPath.item].objectForKey("username") as NSString;
        }
        else{
            label.text="";
        }
        cell.addSubview(label)
        var timer = NSTimer.scheduledTimerWithTimeInterval(Double(0.5), target: self, selector: Selector("reloadLenderData"), userInfo:nil, repeats: false)
//        timer.invalidate()
        println("- - - -- - - - - - - - - - - - - ");
        return cell
    }
    
    // For styling, this is for UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
//    // Touch handler: Tapping a charger removes it
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var lendingUser = Utils.matchingLenders[indexPath.item]
//        lenderList.reloadData();
//
//    }
}

