//
//  ViewController.swift
//  TwilioLookup
//
//  Created by Fabio Borella on 06/21/2016.
//  Copyright (c) 2016 Fabio Borella. All rights reserved.
//

import UIKit
import TwilioLookup

class ViewController: UIViewController {

    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var debugTextView: UITextView!
    
    @IBAction func verifyPhoneNumber(sender: AnyObject) {
        let attributes = [
            NSFontAttributeName : UIFont(name: "Menlo-Bold", size: 10)!,
            NSForegroundColorAttributeName : UIColor.darkGrayColor()
        ]
        self.debugTextView.attributedText = NSAttributedString(string: "Verifying...", attributes: attributes)
        TwilioLookup.lookup(phoneTextField.text!) { (response, error) in
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

