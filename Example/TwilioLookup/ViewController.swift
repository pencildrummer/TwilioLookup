//
//  ViewController.swift
//  TwilioLookup
//
//  Created by Fabio Borella on 06/21/2016.
//  Copyright (c) 2016 Fabio Borella. All rights reserved.
//

import UIKit
import TwilioLookup
import libPhoneNumber_iOS

class ViewController: UIViewController {

    var currentCountryCode: String! {
        didSet {
            formatter = NBAsYouTypeFormatter(regionCode: currentCountryCode)
            
            let prefix = NBPhoneNumberUtil.sharedInstance().getCountryCodeForRegion(currentCountryCode)
            countryCodeButton.setTitle("\(currentCountryCode) +\(prefix)", forState: .Normal)
        }
    }
    
    var formatter: NBAsYouTypeFormatter?
    
    @IBOutlet private var countryCodeButton: UIButton!
    @IBOutlet private var phoneTextField: UITextField!
    @IBOutlet private var debugTextView: UITextView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func verifyPhoneNumber(sender: AnyObject) {
        let attributes = [
            NSFontAttributeName : UIFont(name: "Menlo-Bold", size: 10)!,
            NSForegroundColorAttributeName : UIColor.darkGrayColor()
        ]
        self.debugTextView.attributedText = NSAttributedString(string: "Verifying...", attributes: attributes)
        
        activityIndicator.startAnimating()
        
        TwilioLookup.lookup(phoneTextField.text!, countryCode: currentCountryCode) { (response, error) in
            
            self.activityIndicator.stopAnimating()
            
            if error == nil {
                
                debugPrint(response?.toJSONString(true))
                self.debugTextView.attributedText = NSAttributedString(string: response!.toJSONString(true)!, attributes: attributes)
                
            } else {
                
                self.debugTextView.attributedText = NSAttributedString(string: (error as! TwilioError).toJSONString(true)!, attributes: attributes)
                
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default, handler: nil)
                alert.addAction(closeAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentCountryCode = NSLocale.componentsFromLocaleIdentifier(NSLocale.currentLocale().localeIdentifier)[NSLocaleCountryCode] ?? "US"
        
        phoneTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCountryCodes" {
            (segue.destinationViewController as! CountryCodesViewController).sourceController = self
        }
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if range.length > 0 && string.characters.count == 0 && string == "" {
            textField.text = formatter?.removeLastDigit()
        } else {
            textField.text = formatter?.inputDigit(string)
        }
        
        return false
    }
    
}