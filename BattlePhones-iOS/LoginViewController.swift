//
//  LoginViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/12/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var textField: UITextField!
    
    var loginViewModel = LoginViewModel()
    
    //MARK: Init
    convenience init() {
        self.init(nibName: String(describing: LoginViewController.self), bundle: Bundle.main)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.delegate = self
        textField.delegate = self
        raiseKeyboard()
    }
    
    //MARK: Helper
    func raiseKeyboard() {
        textField.becomeFirstResponder()
    }

}

//MARK: - Textfield Delegate
extension LoginViewController: UITextFieldDelegate {
    
    // Player entered displayname
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let displayName = textField.text else { return false }
        
        let displayNameWithoutWhitespace = loginViewModel.removeWhiteSpace(displayName: displayName)
        
        if loginViewModel.isValid(displayName: displayNameWithoutWhitespace) == .valid {
            loginViewModel.createPlayer(usingDisplayName: displayNameWithoutWhitespace)
            return true
        }
        return false
    }
}

//MARK: - ViewModel Delegate
extension LoginViewController: LoginViewModelDelegate {
    
    func didLogInSuccessfully() {
        dismiss()
    }
    
    func dismiss() {
        let lobbyViewController = LobbyViewController()
        lobbyViewController.modalTransitionStyle = .crossDissolve
        present(lobbyViewController, animated: true, completion: nil)
 
    }
    
    func didFailToLoadUUID(error: CloudKitError) {
        switch error {
        case .notAuthenticated: self.showAlert(title: "Uh oh!", message: "You're not signed into iCloud. Please go to Settings and sign in to your iCloud Account.")
        case .other: self.showAlert(title: "Uh oh!", message: "Something went wrong! Please try again")
        }
    }
    
    func didFailToSavePlayer() {
        showAlert(title: "Uh oh!", message: "Something went wrong! Please try again")
    }
    
    func didBeginLoading() {
        
    }
    
    func didStopLoading() {
        
    }
}
