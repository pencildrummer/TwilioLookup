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

/**
 Class used to lookup phone number using the Lookup feature of Twilio.
 
 To use TwilioLookup methods you need to set the `accountSid` and `accountToken` found in the Twilio console dashboard ([Twilio dashboard](https://www.twilio.com/console/sms/dashboard)).
 */
open class TwilioLookup {
    
    // MARK: - Settings
    
    /**
     The account SID of your account.
     
     You can find your account SID value in the [Twilio dashboard](https://www.twilio.com/console/sms/dashboard)
     */
    open class var accountSid: String? {
        set {
            sharedInstance.accountSid = newValue
        }
        get {
            return sharedInstance.accountSid
        }
    }
    
    /**
     The account Token of your account.
     
     You can find your account Token value in the [Twilio dashboard](https://www.twilio.com/console/sms/dashboard)
     */
    open class var accountToken: String? {
        set {
            sharedInstance.accountToken = newValue
        }
        get {
            return sharedInstance.accountToken
        }
    }
    
    // MARK: - Methods
    
    /**
     Use this method to lookup on Twilio for a certain phone number. You can also pass the country ISO code and the type.
     
     - parameter phoneNumber: The phone number to lookup
     - parameter countryCode: Optional [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the phone number. This is used to specify the country when the number is provided in a national format.
     - parameter type: Indicates the type of information you would like returned with your request. Possible values are `carrier` or `caller-name`. If not specified, the default is nil. This properties is available only on paid accounts.
     - parameter completion: The closure the be executed when the request is finished.
     
     - seealso: TwilioLookupResponse
     */
    open class func lookup(_ phoneNumber: String, countryCode: String? = nil, type: String? = nil, addOns: [TwilioAddOn]? = nil, completion: (TwilioLookupResponse?, NSError?) -> ()) {
        sharedInstance.lookup(phoneNumber, countryCode: countryCode, type: type, addOns: addOns, completion: completion)
    }
    
    // MARK: -
    // MARK: Private vars
    
    fileprivate static let sharedInstance = TwilioLookup()
    
    fileprivate var accountSid: String?
    fileprivate var accountToken: String?
    
    // MARK: Private implementations
    
    fileprivate func lookup(_ phoneNumber: String, countryCode: String?, type: String?, addOns: [TwilioAddOn]?, completion: (TwilioLookupResponse?, NSError?) -> ()) {
        
        var parameters: [String: AnyObject] = [:]
        
        if let countryCode = countryCode {
            parameters["CountryCode"] = countryCode
        }
        
        if let type = type {
            parameters["Type"] = type
        }
        
        if let addOns = addOns {
            var addOnsUniqueNames: [String] = []
            for addOn in addOns {
                addOnsUniqueNames.append(addOn.uniqueName())
            }
            parameters["AddOns"] = addOnsUniqueNames
        }
        
        Alamofire.request(TwilioLookupRouter.Lookup(phoneNumber, parameters))
            .validate(statusCode: 200..<300)
            .responseObject { (response: Response<TwilioLookupResponse, NSError>) in
                switch response.result {
                case .Success(let result):
                    completion(result, nil)
                case .Failure(let error):
                    if let urlError = error as? NSURLError {
                        completion(nil, error)
                    }
                    // Map error response to TwilioError
                    else if let errorJSON = String(data: response.data!, encoding: NSUTF8StringEncoding) {
                        if let twilioError = TwilioError(JSONString: errorJSON) {
                            completion(nil, twilioError)
                        } else {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, error)
                    }
                }
        }
        
    }
    
    
    
}
