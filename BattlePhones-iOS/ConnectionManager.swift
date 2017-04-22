//
//  ConnectionManager.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/17/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Starscream



protocol ConnectionManagerDelegate: class {
    /**
     Called when the client receives the list of currently active players.
     - parameter playerInfo: An array containing dictionaries of player displayNames and UUIDs
     */
    func didReceive(activePlayersInfo playerInfo: [PlayerInfo])
    func didReceive(challengeRequestWith playerInfo: PlayerInfo)
    func didReceive(challengeResponseWith info: [String : String])
}

protocol BattleEventDelegate: class {
    func didReceive(battleEventInfo: [String : String])
}

/// Manages everything concerning websockets! Including connecting, disconnecting, and sending/receiving messages
class ConnectionManager {
    
    static let sharedInstance = ConnectionManager()
    
    weak var connectionDelegate: ConnectionManagerDelegate?
    weak var battleEventDelegate: BattleEventDelegate?
    
    fileprivate let socket = WebSocket(url: URL(string: Routes.builder(usingBase: .ngrokWebSocket, path: nil))!)
    
    enum EventType: String {
        case playerJoinInactive
        case playerJoinActive
        case activePlayers
        case challengeRequest
        case challengeResponse
        case battle
    }
    
    fileprivate init() {
        // Made private to prevent clients from calling init
    }
    
    //MARK: - Private
    
    fileprivate func sendInitialConnectionToServer() {
        guard let currentPlayer = Player.currentPlayer else { return }
        let infoDict = [
            "displayName" : currentPlayer.displayName,
            "uuid"        : currentPlayer.uuid,
            "eventType"   : EventType.playerJoinInactive.rawValue
        ]
        write(usingInfo: infoDict)
    }
    
    
    fileprivate func write(usingInfo info: [String : String]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
               socket.write(string: jsonString)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    //MARK: - Public
    func connect() {
        socket.delegate = self
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
    
    func joinLobby() {
        let infoDict = ["eventType" : EventType.playerJoinActive.rawValue]
        write(usingInfo: infoDict)
    }
    
    func challenge(opponentUsing opponentInfo: PlayerInfo) {
        print("Sending challenge to \(opponentInfo.displayName)")
        let infoDict = [
            "eventType" : EventType.challengeRequest.rawValue,
            "opponentUUID" : opponentInfo.uuid
        ]
        write(usingInfo: infoDict)
    }
    
    func sendChallengeResponse(using opponentInfo: PlayerInfo, isChallengeAccepted: Bool) {
        print("Sending response to \(opponentInfo.displayName)")
        let infoDict = [
            "eventType" : EventType.challengeResponse.rawValue,
            "challengeResponse" : isChallengeAccepted ? "accepted" : "declined",
            "opponentUUID" : opponentInfo.uuid,
        ]
        write(usingInfo: infoDict)
    }
}

//MARK: - WebSocketDelegate
extension ConnectionManager: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        sendInitialConnectionToServer()
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("Received Data: \(data)")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("Socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("Received message from server: \(text)")
    
        let eventType = JSONParser.parse(eventType: text)
        
        if eventType == EventType.activePlayers.rawValue {
            handleActivePlayers(text: text)
        } else if eventType == EventType.challengeRequest.rawValue {
            handleChallengeRequest(text: text)
        } else if eventType == EventType.challengeResponse.rawValue {
            handleChallengeResponse(text: text)
        } else if eventType == EventType.battle.rawValue {
            handleBattleEvents(text: text)
        }
    }
    
    func handleActivePlayers(text: String) {
        let playerInfo = JSONParser.parse(activePlayers: text)
        connectionDelegate?.didReceive(activePlayersInfo: playerInfo)
    }
    
    func handleChallengeRequest(text: String) {
        print("Received challenger request: \(text)")
        let playerInfo = JSONParser.parse(challengeRequest: text)
        connectionDelegate?.didReceive(challengeRequestWith: playerInfo)
    }
    
    func handleChallengeResponse(text: String) {
        print("Received challenge response: \(text)")
        let responseInfo = JSONParser.parse(challengeResponse: text)
        connectionDelegate?.didReceive(challengeResponseWith: responseInfo)
    }
    
    func handleBattleEvents(text: String) {
        print("Received battle event")
        let battleEventInfo = JSONParser.parse(battleEvent: text)
        battleEventDelegate?.didReceive(battleEventInfo: battleEventInfo)
    }
    
    
}
