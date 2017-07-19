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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Locale.isoRegionCodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodeCell", for: indexPath)
        
        let countryCode = Locale.isoRegionCodes[indexPath.row]
        
        cell.textLabel?.text = countryCode
        
        if sourceController?.currentCountryCode == countryCode {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sourceController?.currentCountryCode = Locale.isoRegionCodes[indexPath.row]
        
        dismiss(animated: true, completion: nil)
    }
    
}
