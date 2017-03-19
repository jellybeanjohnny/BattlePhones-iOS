//
//  PlayerInfo.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/19/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

/// Encapsulates basic info about a player. Used to display in TableViews or CollectionViews, and to send/receive data
/// from/to the server
struct PlayerInfo {
    let displayName: String
    let uuid: String
}
