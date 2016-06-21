//
//  TwilioLookupResponse.swift
//  Pods
//
//  Created by Ronnie Della Rocca on 21/06/16.
//
//

import Foundation

/**
 A successful response to a TwilioLookup.lookup() method return an instance of TwilioLookupResponse
 
 - seealso: TwilioLookup
 - seealso: TwilioError
 */
public class TwilioLookupResponse: NSObject, Mappable {
    
    var callerName: String?
    var countryCode: String!
    var phoneNumber: String!
    var nationalFormat: String!
    var carrier: String?
    var addons: [AnyObject]?
    
    // Mappable
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        callerName <- map["caller_name"]
        countryCode <- map["country_code"]
        phoneNumber <- map["phone_number"]
        nationalFormat <- map["national_format"]
        carrier <- map["carrier"]
        addons <- map["addons"]
    }
    
}