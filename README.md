# TwilioLookup

[![CI Status](http://img.shields.io/travis/Fabio Borella/TwilioLookup.svg?style=flat)](https://travis-ci.org/Fabio Borella/TwilioLookup)
[![Version](https://img.shields.io/cocoapods/v/TwilioLookup.svg?style=flat)](http://cocoapods.org/pods/TwilioLookup)
[![License](https://img.shields.io/cocoapods/l/TwilioLookup.svg?style=flat)](http://cocoapods.org/pods/TwilioLookup)
[![Platform](https://img.shields.io/cocoapods/p/TwilioLookup.svg?style=flat)](http://cocoapods.org/pods/TwilioLookup)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

To use __TwilioLookup__ you must have an account on Twilio. You can register a new one on the [Twilio sign up page](https://www.twilio.com/try-twilio).

Once you have an account you can configure __TwilioLookup__ to use it.

Find in the [Twilio dashboard](https://www.twilio.com/console/sms/dashboard), by clicking on the _"Show API Credentials"_ link on the upper right corner, your `Account SID` and `Account Token` and configure them as shown below.

One of the best place to configure __TwilioLookup__ is in the `application(_, didFinishLaunchingWithOptions:)` implementation.

```
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

// ...

TwilioLookup.accountSid = "ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
TwilioLookup.accountToken = "your_auth_token"

return true
}
```

## Installation

__TwilioLookup__ is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TwilioLookup"
```

## Author

Fabio Borella, info@pencildrummer.com

## License

TwilioLookup is available under the MIT license. See the LICENSE file for more info.
