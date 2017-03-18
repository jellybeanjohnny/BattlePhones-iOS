//
//  ConnectionManager.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/17/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Starscream


protocol ConnectionManagerDelegate {
    
}

/// Manages everything concerning websockets! Including connecting, disconnecting, and sending/receiving messages
class ConnectionManager {
    
    static let sharedInstance = ConnectionManager()
    
    fileprivate let socket = WebSocket(url: URL(string: Routes.builder(usingBase: .baseLocalhostWebSocket, path: nil))!)
    
    enum EventType: String {
        case playerJoined
    }
    
    fileprivate init() {
        // Made private to prevent clients from calling init
    }
    
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
        //TODO: Stub
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
