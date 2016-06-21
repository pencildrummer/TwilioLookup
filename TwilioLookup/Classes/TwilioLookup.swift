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

public class TwilioLookup {
    
    public static let sharedInstance = TwilioLookup()
    
    public var accountSid: String?
    public var accountToken: String?
    
    public class func lookup(phoneNumber: String, countryCode: String? = nil, type: String? = nil, completion: (TwilioLookupResponse?, NSError?) -> ()) {
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
            .validate(statusCode: 200..<300)
            .responseObject { (response: Response<TwilioLookupResponse, NSError>) in
                switch response.result {
                case .Success:
                    completion(response.result.value!, nil)
                case .Failure:
                    // Map error response to TwilioError
                    if let errorJSON = String(data: response.data!, encoding: NSUTF8StringEncoding) {
                        if let twilioError = TwilioError(JSONString: errorJSON) {
                            completion(nil, twilioError)
                        }
                    } else {
                        completion(nil, response.result.error!)
                    }
                }
        }
        
    }
    
    
    
}

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

let kTwilioErrorDomain = "com.pencildrummer.TwilioErrorDomain"

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