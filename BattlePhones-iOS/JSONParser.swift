//
//  JSONParser.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/14/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JSONParser {
    static func parse(using value: Any) -> Player {
        
        let json = JSON(value)
        let playerJSON = json["player"]
    
        let stats = PlayerStats.convert(usingJSON: playerJSON)
        let items = Item.convert(usingJSON: playerJSON)
        let attacks = Attack.convert(usingJson: playerJSON)
        
        let player = Player.convert(usingJSON: playerJSON, attacks: attacks, items: items, stats: stats)
        
        return player
    }
}
