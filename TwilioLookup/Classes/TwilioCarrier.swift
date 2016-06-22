//
//  TwilioCarrier.swift
//  Pods
//
//  Created by Fabio Borella on 22/06/16.
//
//

import Foundation

public enum TwilioCarrierType: String {
    /// The phone number is a landline number generally not capable of receiving SMS messages.
    case Landline = "landline"
    /// The phone number is a mobile number generally capable of receiving SMS messages.
    case Mobile = "mobile"
    /// An internet based phone number that may or may not be capable of receiving SMS messages. For example, Google Voice.
    case Voip = "voip"
}

public enum TwilioCarrierCallerType: String {
    case Unavailable = "unavailable"
    case Business = "business"
    case Consumer = "consumer"
}

public class TwilioCarrier {
    
    /// The mobile country code of the carrier (for mobile numbers only).
    var mobileCountryCode: String!
    /// The mobile network code of the carrier (for mobile numbers only).
    var mobileNetworkCode: String!
    /// The name of the carrier. Please bear in mind that carriers rebrand themselves constantly and that the names used for carriers will likely change over time.
    var name: String!
    /// The phone number type. See `TwilioCarrierType` for more information.
    var type: TwilioCarrierType!
    /// The error code, if any, associated with your request.
    var errorCode: TwilioErrorCode?
    
}
