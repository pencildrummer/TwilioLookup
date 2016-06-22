//
//  CountryCodesViewController.swift
//  TwilioLookup
//
//  Created by FAbio Borella on 22/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class CountryCodesViewController: UITableViewController {
    
    var sourceController: ViewController?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NSLocale.ISOCountryCodes().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CountryCodeCell", forIndexPath: indexPath)
        
        let countryCode = NSLocale.ISOCountryCodes()[indexPath.row]
        
        cell.textLabel?.text = countryCode
        
        if sourceController?.currentCountryCode == countryCode {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        sourceController?.currentCountryCode = NSLocale.ISOCountryCodes()[indexPath.row]
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}