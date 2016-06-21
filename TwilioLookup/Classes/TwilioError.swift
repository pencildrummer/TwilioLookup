//
//  TwilioError.swift
//  Pods
//
//  Created by Ronnie Della Rocca on 21/06/16.
//
//

import Foundation
import ObjectMapper

/// TwilioError errors domain.
let kTwilioErrorDomain = "com.pencildrummer.TwilioErrorDomain"

/**
 This is the default class used to represent the Twilio error responses.
 
 - seealso: TwilioLookup
 - seealso: TwilioLookupResponse
 */
public class TwilioError: NSError, Mappable {
    
    /// Twilio-specific error code. For a complete list look the [Error Code Reference](https://www.twilio.com/docs/api/errors/reference).
    public var twilioCode: UInt!
    /// Additional info to debug the error.
    public var moreInfoDescription: String!
    /// The HTTP status code of the error response.
    public var status: UInt!
    
    private var twilioDescription: String!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public init?(_ map: Map) {
        super.init(domain: kTwilioErrorDomain,
                   code: map.JSONDictionary["code"] as! Int,
                   userInfo: [
                    NSLocalizedDescriptionKey : map.JSONDictionary["message"] as! String
            ])
    }
    
    public func mapping(map: Map) {
        twilioCode <- map["code"]
        twilioDescription <- map["message"]
        moreInfoDescription <- map["more_info"]
        status <- map["status"]
    }
    
    public override var localizedDescription: String {
        return twilioDescription
    }
    
}