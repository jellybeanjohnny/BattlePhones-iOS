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
    func didLogInSuccessfully()
    func didFailToLoadUUID(error: CloudKitError)
    func didFailToSavePlayer()
    func didBeginLoading()
    func didStopLoading()
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    func removeWhiteSpace(displayName: String) -> String {
        return displayName.replacingOccurrences(of: " ", with: "")
    }
    
    /// A display name is valid so long as it consists of no whitespace characters and is not an empty string
    func isValid(displayName: String) -> LoginValidationState {
        if displayName.isEmpty {
            return .emptyText
        }
        return .valid
    }
    
    func createPlayer(usingDisplayName displayName: String) {
        
        delegate?.didBeginLoading()
        
        CloudKitService.loadCloudKitID { (uuid, error) in
            if let error = error {
                self.delegate?.didFailToLoadUUID(error: error)
                self.delegate?.didStopLoading()
            } else if let uuid = uuid {
                self.savePlayer(withDisplayName: displayName, uuid: uuid)
            }
        }
    }
    
    fileprivate func savePlayer(withDisplayName displayName: String, uuid: String) {
        PlayerService.saveNewPlayer(withDisplayName: displayName, uuid: uuid, success: { player in
            Player.save(player: player)
            LoginStateManager.update(uuid: uuid)
            self.delegate?.didLogInSuccessfully()
            self.delegate?.didStopLoading()
        }, failure: {
            print("Failure")
            self.delegate?.didFailToSavePlayer()
            self.delegate?.didStopLoading()
        })
    }
    
    
}
