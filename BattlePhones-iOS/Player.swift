//
//  Player.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Player {
    var displayName: String
    let uuid: String
    let attacks: [Attack]
    let items: [Item]
    let stats: PlayerStats
    var gold: Int
    
    var description: String {
        return "displayName: \(displayName)\nUUID: \(uuid)\nattacks: \(attacks)\nitems: \(items)\nstats: \(stats)\ngold: \(gold)"
    }
}

extension Player {
    
    static func convert(usingJSON playerJSON: JSON, attacks: [Attack], items: [Item], stats: PlayerStats) -> Player {
        let displayName = playerJSON["displayName"].stringValue
        let gold = playerJSON["gold"].intValue
        let uuid = playerJSON["uuid"].stringValue
        
        let player = Player(displayName: displayName, uuid: uuid, attacks: attacks, items: items, stats: stats, gold: gold)
        
        return player
    }
}
