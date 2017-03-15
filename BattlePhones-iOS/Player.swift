//
//  Player.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

struct Player {
    var displayName: String
    let uuid: String
    let attacks: [Attack]
    let items: [Item]
    let stats: [PlayerStats]
    var gold: Float
}
