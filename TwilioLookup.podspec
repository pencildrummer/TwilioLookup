#
# Be sure to run `pod lib lint TwilioLookup.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TwilioLookup'
  s.version          = '1.0.0'
  s.summary          = 'TwilioLookup is a library to help you check phone numbers using the Twilio Lookups service'

  s.homepage         = 'https://github.com/pencildrummer/TwilioLookup'
  s.license          = 'MIT'
  s.author           = { 'Fabio Borella' => 'info@pencildrummer.com' }
  s.source           = { :git => 'https://github.com/pencildrummer/TwilioLookup.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TwilioLookup/Sources/*.swift'

  s.dependency 'Alamofire'
  s.dependency 'AlamofireObjectMapper', '~> 3.0'

end
