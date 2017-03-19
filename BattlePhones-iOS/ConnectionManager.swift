//
//  ConnectionManager.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/17/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Starscream
import SwiftyJSON


protocol ConnectionManagerDelegate: class {
    /**
     Called when the client receives the list of currently active players.
     - parameter playerInfo: An array containing dictionaries of player displayNames and UUIDs
     */
    func didReceive(activePlayersInfo playerInfo: [[String : String]])
}

/// Manages everything concerning websockets! Including connecting, disconnecting, and sending/receiving messages
class ConnectionManager {
    
    static let sharedInstance = ConnectionManager()
    
    weak var delegate: ConnectionManagerDelegate?
    
    fileprivate let socket = WebSocket(url: URL(string: Routes.builder(usingBase: .ngrokWebSocket, path: nil))!)
    
    enum EventType: String {
        case playerJoinInactive
        case playerJoinActive
        case activePlayers
    }
    
    fileprivate init() {
        // Made private to prevent clients from calling init
    }
    
    //MARK: - Private
    
    fileprivate func sendInitialConnectionToServer() {
        guard let currentPlayer = Player.currentPlayer() else { return }
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
            let jsonString = String(data: jsonData, encoding: .utf8)!
            socket.write(string: jsonString)
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
        
        let json = JSON(parseJSON: text)
        let eventType = json["eventType"].stringValue
        
        if eventType == EventType.activePlayers.rawValue {
            handleActivePlayers(json: json)
        } else {
            // other events
        }
    }
    
    func handleActivePlayers(json: JSON) {
        let playerInfoArray = parseActivePlayers(json: json)
        delegate?.didReceive(activePlayersInfo: playerInfoArray)
    }
    
    func parseActivePlayers(json: JSON) -> [[String : String]] {
        let info = json["activePlayers"].arrayValue.map {
            return ["uuid" : $0["uuid"].stringValue, "displayName" : $0["displayName"].stringValue]
        }
        return info
    }
    
}
