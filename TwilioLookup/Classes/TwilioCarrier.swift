//
//  TwilioCarrier.swift
//  Pods
//
//  Created by Fabio Borella on 22/06/16.
//
//

import Foundation

/**
 Available types of carrier
 */
public enum TwilioCarrierType: String {
    /// The phone number is a landline number generally not capable of receiving SMS messages.
    case Landline = "landline"
    /// The phone number is a mobile number generally capable of receiving SMS messages.
    case Mobile = "mobile"
    /// An internet based phone number that may or may not be capable of receiving SMS messages. For example, Google Voice.
    case Voip = "voip"
}

/**
 Available types of carrier caller
 */
public enum TwilioCarrierCallerType: String {
    /// The carrier caller is not available
    case Unavailable = "unavailable"
    /// The carrier caller is a business number
    case Business = "business"
    /// The carrier caller is a consumer number
    case Consumer = "consumer"
}

/**
 The carrier of a certain phone number
 
 - seealso: TwilioLookupResponse
 */
public class TwilioCarrier {
    
    /**
     The mobile country code of the carrier (for mobile numbers only).
     */
    public var mobileCountryCode: String!
    
    /** 
     The mobile network code of the carrier (for mobile numbers only). 
     */
    public var mobileNetworkCode: String!
    
    /** 
     The name of the carrier. Please bear in mind that carriers rebrand themselves constantly and that the names used for carriers will likely change over time. 
     */
    public var name: String!
    
    /**
     The phone number type. See `TwilioCarrierType` for more information. 
     */
    public var type: TwilioCarrierType!
    
    /** 
     The error code, if any, associated with your request.
     */
    public var errorCode: TwilioErrorCode?
    
}