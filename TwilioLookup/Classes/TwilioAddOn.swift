//
//  TwilioAddOn.swift
//  Pods
//
//  Created by Fabio Borella on 22/06/16.
//
//

import Foundation

/**
 Protocol to implement when creating a TwilioAddOn
 */
public protocol TwilioAddOn {
    
    /// The unique name of the add on
    func uniqueName() -> String
    
}