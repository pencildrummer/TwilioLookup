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
    
    case lookup(String, [String: Any]?)
    
    fileprivate var baseURL: URL {
        return URL(string: TwilioLookupRouter.baseURL)!
    }
    
    fileprivate var method: Alamofire.HTTPMethod {
        switch self {
        case .lookup(_, _):
            return .get
        }
    }
    
    fileprivate var requestURL: URL? {
        switch self {
        case .lookup(let phoneNumber, _):
            return baseURL.appendingPathComponent("PhoneNumbers").appendingPathComponent(phoneNumber).appendingPathComponent("/")
        }
    }
    
    fileprivate var parameters: [String: Any]? {
        switch self {
        case .lookup(_, let params):
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: requestURL!)
        request.httpMethod = method.rawValue
        
        // Configure authorization
        
        let basicAuthHeader = basicAuthorizationHeader(TwilioLookup.accountSid!, token: TwilioLookup.accountToken!)
        request.setValue(basicAuthHeader, forHTTPHeaderField: "Authorization")
        
        // Configure parameters
        
        return try Alamofire.URLEncoding.default.encode(request, with: parameters)
    }
    
    fileprivate func basicAuthorizationHeader(_ sid: String, token: String) -> String {
        let credentials = "\(sid):\(token)"
        let credentialsData = credentials.data(using: String.Encoding.utf8)!
        return "Basic \(credentialsData.base64EncodedString(options: []))"
    }
    
}
