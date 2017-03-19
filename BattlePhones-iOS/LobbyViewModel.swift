//
//  LobbyViewModel.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/18/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

protocol LobbyViewModelDelegate: class {
    func refresh()
}

class LobbyViewModel {
    
    weak var delegate: LobbyViewModelDelegate?
    
    var activePlayers: [[String : String]] = []
    
    func viewDidLoad() {
        startConnection()
    }
    
    func joinLobby() {
        ConnectionManager.sharedInstance.joinLobby()
    }
    
    func displayName(forRowAtIndexPath indexPath: IndexPath) -> String {
        guard let displayName = activePlayers[indexPath.row]["displayName"] else {
            return ""
        }
        return displayName
    }
    
    
    fileprivate func startConnection() {
        ConnectionManager.sharedInstance.delegate = self
        ConnectionManager.sharedInstance.connect()
    }
    
}

extension LobbyViewModel: ConnectionManagerDelegate {
    
    func didReceive(activePlayersInfo playerInfo: [[String : String]]) {
        activePlayers = playerInfo
        delegate?.refresh()
    }
}
