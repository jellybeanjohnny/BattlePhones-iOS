//
//  LoginViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/12/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        raiseKeyboard()
        
        
    }
    
    func raiseKeyboard() {
        textField.becomeFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {
    // Player entered displayname
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let displayName = textField.text, isValid(displayName: displayName) {
            // send post request to /player including displayname and cloudkit id
        }
        return false
    }
    
    /// A display name is valid so long as it consists of no whitespace characters and is not an empty string
    func isValid(displayName: String) -> Bool {
        let removedWhiteSpaceName = displayName.replacingOccurrences(of: " ", with: "")
        return !removedWhiteSpaceName.isEmpty
    }
}
