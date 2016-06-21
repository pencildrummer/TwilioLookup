//
//  TwilioLookup.swift
//  Pods
//
//  Created by Fabio Borella on 21/06/16.
//
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class TwilioLookup {
    
    static let sharedInstance = TwilioLookup()
    
    var accountSid: String?
    var accountToken: String?
    
    class func lookup(phoneNumber: String, countryCode: String?, type: String?, completion: (TwilioLookupResponse?, NSError?) -> ()) {
        sharedInstance.lookup(phoneNumber, countryCode: countryCode, type: type, completion: completion)
    }
    
    private func lookup(phoneNumber: String, countryCode: String?, type: String?, completion: (TwilioLookupResponse?, NSError?) -> ()) {
        
        var parameters: [String: AnyObject] = [:]
        
        if let countryCode = countryCode {
            parameters["CountryCode"] = countryCode
        }
        
        if let type = type {
            parameters["Type"] = type
        }
        
        Alamofire.request(TwilioLookupRouter.Lookup(phoneNumber, parameters))
            .responseObject { (response: Response<TwilioLookupResponse, NSError>) in
                switch response.result {
                case .Success:
                    completion(response.result.value!, nil)
                case .Failure:
                    completion(nil, response.result.error!)
                }
        }
        
    }
    
    
    
}

class TwilioLookupResponse: NSObject, Mappable {
    
    var callerName: String?
    var countryCode: String!
    var phoneNumber: String!
    var nationalFormat: String!
    var carrier: String?
    var addons: [AnyObject]?
    
    // Mappable
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        callerName <- map["caller_name"]
        countryCode <- map["country_code"]
        phoneNumber <- map["phone_number"]
        nationalFormat <- map["national_format"]
        carrier <- map["carrire"]
        addons <- map["addons"]
    }
    
}