//
//  TwilioError.swift
//  Pods
//
//  Created by Ronnie Della Rocca on 21/06/16.
//
//

import Foundation
import ObjectMapper

let kTwilioErrorDomain = "com.pencildrummer.TwilioErrorDomain"

/**
 This is the default class used to represent the Twilio error responses.
 
 - seealso: TwilioLookup
 - seelaso: TwilioLookupResponse
 */
public class TwilioError: NSError, Mappable {
    
    public var twilioCode: UInt!
    private var twilioDescription: String!
    public var moreInfoDescription: String!
    public var status: UInt!
    
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