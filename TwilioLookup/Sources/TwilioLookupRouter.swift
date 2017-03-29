//
//  TwilioLookupRouter.swift
//  Pods
//
//  Created by Fabio Borella on 21/06/16.
//
//

import Foundation
import Alamofire

internal enum TwilioLookupRouter: URLRequestConvertible {
    
    fileprivate static let baseURL = "https://lookups.twilio.com/v1/"
    
    case lookup(String, [String: AnyObject]?)
    
    fileprivate var baseURL: URL {
        return URL(string: TwilioLookupRouter.baseURL)!
    }
    
    fileprivate var method: Alamofire.Method {
        switch self {
        case .lookup(_, _):
            return .GET
        }
    }
    
    fileprivate var requestURL: URL? {
        switch self {
        case .lookup(let phoneNumber, _):
            return baseURL.appendingPathComponent("PhoneNumbers")!.appendingPathComponent(phoneNumber)!.appendingPathComponent("/")
        }
    }
    
    fileprivate var parameters: [String: AnyObject]? {
        switch self {
        case .lookup(_, let params):
            return params
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: requestURL!)
        request.HTTPMethod = method.rawValue
        
        // Configure authorization
        
        let basicAuthHeader = basicAuthorizationHeader(TwilioLookup.accountSid!, token: TwilioLookup.accountToken!)
        request.setValue(basicAuthHeader, forHTTPHeaderField: "Authorization")
        
        // Configure parameters
        
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
    }
    
    fileprivate func basicAuthorizationHeader(_ sid: String, token: String) -> String {
        let credentials = "\(sid):\(token)"
        let credentialsData = credentials.data(using: String.Encoding.utf8)!
        return "Basic \(credentialsData.base64EncodedString(options: []))"
    }
    
}
