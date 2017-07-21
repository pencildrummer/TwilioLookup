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
            
            let prefix = NBPhoneNumberUtil.sharedInstance().getCountryCode(forRegion: currentCountryCode)
            countryCodeButton.setTitle("\(currentCountryCode!) +\(String(describing: prefix!))", for: UIControlState())
        }
    }
    
    var formatter: NBAsYouTypeFormatter?
    
    @IBOutlet fileprivate var countryCodeButton: UIButton!
    @IBOutlet fileprivate var phoneTextField: UITextField!
    @IBOutlet fileprivate var debugTextView: UITextView!
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func verifyPhoneNumber(_ sender: AnyObject) {
        let attributes = [
            NSFontAttributeName : UIFont(name: "Menlo-Bold", size: 10)!,
            NSForegroundColorAttributeName : UIColor.darkGray
        ]
        self.debugTextView.attributedText = NSAttributedString(string: "Verifying...", attributes: attributes)
        
        activityIndicator.startAnimating()
        
        TwilioLookup.shared.lookup(phoneTextField.text!, countryCode: currentCountryCode) { (response, error) in
            
            self.activityIndicator.stopAnimating()
            
            if error == nil {
                
                debugPrint(response?.toJSONString(prettyPrint: true) ?? "No JSONString response")
                self.debugTextView.attributedText = NSAttributedString(string: response!.toJSONString(prettyPrint: true)!, attributes: attributes)
                
            } else {
                
                self.debugTextView.attributedText = NSAttributedString(string: (error as! TwilioError).toJSONString(prettyPrint: true)!, attributes: attributes)
                
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alert.addAction(closeAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentCountryCode = Locale.current.regionCode ?? "US"
        
        phoneTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCountryCodes" {
            (segue.destination as! CountryCodesViewController).sourceController = self
        }
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length > 0 && string.characters.count == 0 && string == "" {
            textField.text = formatter?.removeLastDigit()
        } else {
            textField.text = formatter?.inputDigit(string)
        }
        
        return false
    }
    
}
