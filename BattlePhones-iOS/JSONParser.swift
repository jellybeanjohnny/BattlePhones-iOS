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
    
    static func parse(eventType jsonString: String) -> String {
        let json = JSON(parseJSON: jsonString)
        let eventType = json["eventType"].stringValue
        return eventType
    }
    
    static func parse(activePlayers text: String) -> [PlayerInfo] {
        let json = JSON(parseJSON: text)
        let info = json["activePlayers"].arrayValue.map {
            PlayerInfo(displayName: $0["displayName"].stringValue, uuid: $0["uuid"].stringValue)
        }
        return info
    }
    
    static func parse(challengeRequest text: String) -> PlayerInfo {
        let json = JSON(parseJSON: text)
        let challengerDisplayName = json["challengerDisplayName"].stringValue
        let challengerUUID = json["challengerUUID"].stringValue
        return PlayerInfo(displayName: challengerDisplayName, uuid: challengerUUID)
    }
    
    static func parse(challengeResponse text: String) -> [String : String] {
        let json = JSON(parseJSON: text)
        let info = ["opponentUUID" : json["opponentUUID"].stringValue,
                    "challengeResponse" : json["challengeResponse"].stringValue]
        return info
    }
    
    /// parses the returned message from the server containing information about both players after processing each turn
    static func parse(battleEvent text: String) -> [String : String] {
        //TODO: add appropriate fields for updating the display info on each side
        let json = JSON(parseJSON: text)
        let info = ["battleEventType" : json["battleEventType"].stringValue,
                    "description" : json["description"].stringValue]
        return info
    }
}
