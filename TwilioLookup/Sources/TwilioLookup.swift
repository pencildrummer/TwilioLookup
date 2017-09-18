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

internal let kTwilioApiSIDKey = "TWApiSID"
internal let kTwilioApiSecretKey = "TWApiSecret"

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
            shared.accountSid = newValue
        }
        get {
            return shared.accountSid
        }
    }
    
    /**
     The account Token of your account.
     
     You can find your account Token value in the [Twilio dashboard](https://www.twilio.com/console/sms/dashboard)
     */
    open class var accountToken: String? {
        set {
            shared.accountToken = newValue
        }
        get {
            return shared.accountToken
        }
    }
    
    // MARK: - Methods
    
    /*open class func lookup(_ phoneNumber: String, countryCode: String? = nil, type: String? = nil, addOns: [TwilioAddOn]? = nil, completion: (TwilioLookupResponse?, Error?) -> ()) {
        TwilioLookup.sharedInstance.lookup(phoneNumber, countryCode: countryCode, type: type, addOns: addOns, completion: completion)
    }*/
    
    // MARK: -
    // MARK: Private vars
    
    public static let shared = TwilioLookup()
    
    internal var accountSid: String?
    internal var accountToken: String?
    
    // MARK: Implementations
    
    /**
     Use this method to lookup on Twilio for a certain phone number. You can also pass the country ISO code and the type.
     
     - parameter phoneNumber: The phone number to lookup
     - parameter countryCode: Optional [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the phone number. This is used to specify the country when the number is provided in a national format.
     - parameter type: Indicates the type of information you would like returned with your request. Possible values are `carrier` or `caller-name`. If not specified, the default is nil. This properties is available only on paid accounts.
     - parameter completion: The closure the be executed when the request is finished.
     
     - seealso: TwilioLookupResponse
     */
    
    public func lookup(_ phoneNumber: String, countryCode: String?, type: String? = nil, addOns: [TwilioAddOn]? = nil, completion: @escaping (TwilioLookupResponse?, Error?) -> ()) {
        
        // Verify configuration
        
        accountSid = accountSid ?? Bundle.main.infoDictionary?[kTwilioApiSIDKey] as? String
        accountToken = accountToken ?? Bundle.main.infoDictionary?[kTwilioApiSecretKey] as? String
        
        guard let _ = accountSid else {
            fatalError("ERROR: Missing accountSid or TWApiSID key in Info.plist")
        }
        guard let _ = accountToken else {
            fatalError("ERROR: Missing accountToken or TWApiSecret key in Info.plist")
        }
        
        var parameters: [String: Any] = [:]
        
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
        
        Alamofire.request(TwilioLookupRouter.lookup(phoneNumber, parameters))
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<TwilioLookupResponse>) in
                switch response.result {
                case .success(let result):
                    completion(result, nil)
                case .failure(let error):
                    if let urlError = error as? URLError {
                        completion(nil, urlError)
                    }
                    // Map error response to TwilioError
                    else if let errorJSON = String(data: response.data!, encoding: String.Encoding.utf8) {
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
