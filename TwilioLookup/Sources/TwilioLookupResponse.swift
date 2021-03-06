//
//  TwilioLookupResponse.swift
//  Pods
//
//  Created by Fabio Borella on 21/06/16.
//
//

import Foundation
import ObjectMapper

/**
 A successful response to a `lookup(_:countryCode:type:addOns:completion:)` method return an instance of this class.
 
 - seealso: TwilioLookup
 - seealso: TwilioError
 */
open class TwilioLookupResponse: NSObject, Mappable {
    
    /** 
     String indicating the name of the owner of the phone number. If not available, this will return `nil`.
     */
    var callerName: String?
    
    /** 
     The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for the phone number.
     */
    var countryCode: String!
    
    /** 
     The phone number, in [E.164](https://en.wikipedia.org/wiki/E.164) format (i.e. "+1").
     */
    var phoneNumber: String!
    
    /** 
     The phone number, in national format.
     */
    var nationalFormat: String!
    
    /** 
     The carrier information if requested.
     */
    var carrier: TwilioCarrier?
    
    /** 
     [TODO] Results of any Add-ons you have specified using the AddOn parameter in the request, as a JSON dictionary. For the format of the dictionary, refer to Using Add-ons 6 section in the Add-ons documentation.
     */
    var addons: [TwilioAddOn]?
    
    // Mappable
    
    /**
     Init method needed to conform to Mappable protocol
     */
    required public init?(map: Map) {
        
    }
    
    /**
     Mapping function needed to conform to Mappable protocol
     */
    open func mapping(map: Map) {
        callerName <- map["caller_name"]
        countryCode <- map["country_code"]
        phoneNumber <- map["phone_number"]
        nationalFormat <- map["national_format"]
        carrier <- map["carrier"]
        addons <- map["add_ons"]
    }
    
}
