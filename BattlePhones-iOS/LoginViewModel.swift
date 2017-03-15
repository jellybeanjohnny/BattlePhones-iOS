//
//  LoginViewModel.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Alamofire

enum LoginValidationState {
    case valid
    case emptyText
}

protocol LoginViewModelDelegate: class {
    func playerDidLogIn()
    func didFailToLoadUUID(error: CloudKitError)
}

struct LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    /// A display name is valid so long as it consists of no whitespace characters and is not an empty string
    func isValid(displayName: String) -> LoginValidationState {
        let removedWhiteSpaceName = displayName.replacingOccurrences(of: " ", with: "")
        if removedWhiteSpaceName.isEmpty {
            return .emptyText
        }
        return .valid
    }
    
    func createPlayer(usingDisplayName displayName: String) {
        
        CloudKitService.loadCloudKitID { (uuid, error) in
            if let error = error {
                self.delegate?.didFailToLoadUUID(error: error)
            } else if let uuid = uuid {
                self.savePlayer(withDisplayName: displayName, uuid: uuid)
            }
        }
    }
    
    fileprivate func savePlayer(withDisplayName displayName: String, uuid: String) {
        PlayerService.saveNewPlayer(withDisplayName: displayName, uuid: uuid) { 
            self.delegate?.playerDidLogIn()
        }
    }
    
}
