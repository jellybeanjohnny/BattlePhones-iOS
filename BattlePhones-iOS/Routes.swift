//
//  Routes.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/14/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

enum Path: String {
    case player = "player"
}

enum Base: String {
    case baseLocalhostHTTP = "http://localhost:8080/"
    case baseLocalhostWebSocket = "ws://localhost:8080/"
    case baseRemoteHTTP = "https://battlephones-server.herokuapp.com/"
    case baseRemoteWebSocket = "ws://battlephones-server.herokuapp.com/"
    case ngrokHTTP = "http://c03d2079.ngrok.io"
    case ngrokWebSocket = "ws://c03d2079.ngrok.io"
}

struct Routes {
    

    static func builder(usingBase base: Base, path:  Path?) -> String {
        if let path = path {
            return base.rawValue + path.rawValue
        }
        return base.rawValue
    }
    
}
