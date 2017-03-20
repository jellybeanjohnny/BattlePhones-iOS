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
    
    var activePlayers: [PlayerInfo] = []
    
    func viewDidLoad() {
        startConnection()
    }
    
    func joinLobby() {
        ConnectionManager.sharedInstance.joinLobby()
    }
    
    func displayName(forRowAtIndexPath indexPath: IndexPath) -> String {
        return activePlayers[indexPath.row].displayName
    }
    
    func didSelectRow(atIndexPath indexPath: IndexPath) {
        let opponentInfo = activePlayers[indexPath.row]
        sendChallengeRequest(withInfo: opponentInfo)
    }
    
    fileprivate func sendChallengeRequest(withInfo opponentInfo: PlayerInfo) {
        ConnectionManager.sharedInstance.challenge(opponentUsing: opponentInfo)
    }
    
    fileprivate func startConnection() {
        ConnectionManager.sharedInstance.delegate = self
        ConnectionManager.sharedInstance.connect()
    }
    
}

extension LobbyViewModel: ConnectionManagerDelegate {
    
    func didReceive(activePlayersInfo playerInfo: [PlayerInfo]) {
        filterAndSetActivePlayers(playerInfo: playerInfo)
        delegate?.refresh()
    }
    
    func filterAndSetActivePlayers(playerInfo: [PlayerInfo]) {
        guard let currentPlayerUUID = Player.currentPlayer?.uuid else { return }
        activePlayers = playerInfo.filter{ $0.uuid != currentPlayerUUID }
    }
    
    func didReceive(challengeRequestWith playerInfo: PlayerInfo) {
        // Immediately accept for now, present battle screen
        print("present battle screen...")
        ConnectionManager.sharedInstance.sendChallengeResponse(using: playerInfo, isChallengeAccepted: true)
    }
    
    func didReceive(challengeResponseWith info: [String : String]) {
        print("present battle screen...")
    }
}
