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


protocol ConnectionManagerDelegate {
    
}

/// Manages everything concerning websockets! Including connecting, disconnecting, and sending/receiving messages
class ConnectionManager {
    
    static let sharedInstance = ConnectionManager()
    
    fileprivate let socket = WebSocket(url: URL(string: Routes.builder(usingBase: .baseRemoteWebSocket, path: nil))!)
    
    enum EventType: String {
        case playerJoined
    }
    
    fileprivate init() {
        // Made private to prevent clients from calling init
    }
    
    //MARK: - Private
    
    fileprivate func sendPlayerInfoToServer() {
        guard let currentPlayer = Player.currentPlayer() else { return }
        let infoDict = [
            "displayName" : currentPlayer.displayName,
            "uuid"        : currentPlayer.uuid,
            "eventType"   : EventType.playerJoined.rawValue
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
    
}

//MARK: - WebSocketDelegate
extension ConnectionManager: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        sendPlayerInfoToServer()
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        //TODO: Stub
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        //TODO: Stub
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        //TODO: Stub
    }
    
}
