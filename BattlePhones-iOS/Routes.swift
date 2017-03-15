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
    case baseHTTP = "http://localhost:8080/"
}

struct Routes {
    

    static func builder(usingBase base: Base, path:  Path?) -> String {
        if let path = path {
            return base.rawValue + path.rawValue
        }
        return base.rawValue
    }
    
}
