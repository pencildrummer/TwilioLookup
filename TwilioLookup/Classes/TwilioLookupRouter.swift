//
//  TwilioLookupRouter.swift
//  Pods
//
//  Created by Fabio Borella on 21/06/16.
//
//

import Alamofire

internal enum TwilioLookupRouter: URLRequestConvertible {
    
    private static let baseURL = "https://lookups.twilio.com/v1/"
    
    case Lookup(String, [String: AnyObject]?)
    
    private var baseURL: NSURL {
        return NSURL(string: TwilioLookupRouter.baseURL)!
    }
    
    private var method: Alamofire.Method {
        switch self {
        case .Lookup(_, _):
            return .GET
        default:
            return .GET
        }
    }
    
    private var requestURL: NSURL? {
        switch self {
        case .Lookup(let phoneNumber, _):
            return baseURL.URLByAppendingPathComponent("PhoneNumbers").URLByAppendingPathComponent(phoneNumber).URLByAppendingPathComponent("/")
        default:
            return nil
        }
    }
    
    private var parameters: [String: AnyObject]? {
        switch self {
        case .Lookup(_, let params):
            return params
        default:
            return nil
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = method.rawValue
        
        // Configure authorization
        
        let basicAuthHeader = basicAuthorizationHeader(TwilioLookup.accountSid!, token: TwilioLookup.accountToken!)
        request.setValue(basicAuthHeader, forHTTPHeaderField: "Authorization")
        
        // Configure parameters
        
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
    }
    
    private func basicAuthorizationHeader(sid: String, token: String) -> String {
        let credentials = "\(sid):\(token)"
        let credentialsData = credentials.dataUsingEncoding(NSUTF8StringEncoding)!
        return "Basic \(credentialsData.base64EncodedStringWithOptions([]))"
    }
    
}
