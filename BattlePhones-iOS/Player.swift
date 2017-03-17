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
    
    static func save(player: Player) {
        
        let playerDict = player.propertyListRepresentation()
        let playerData = NSKeyedArchiver.archivedData(withRootObject: playerDict)
        if let url = Player.playerURL() {
            try? playerData.write(to: url)
        }
    }
    
    static func currentPlayer() -> Player? {
        
        if let url  = Player.playerURL(),
            let playerData = try? Data(contentsOf: url),
            let playerDict = NSKeyedUnarchiver.unarchiveObject(with: playerData) as? NSDictionary,
            let player = Player(propertyListRepresentation: playerDict) {
            
            return player
        }
        
        return nil
    }
    
   fileprivate static func playerURL() -> URL? {
        let fileManager = FileManager.default
        guard let docURL = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return nil
        }
        
        let playerURL = docURL.appendingPathComponent("player.plist")

        return playerURL
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


extension Player: PropertyListConvertible {
    
    init?(propertyListRepresentation: NSDictionary) {
        guard let displayName = propertyListRepresentation["displayName"] as? String,
              let uuid = propertyListRepresentation["uuid"] as? String,
              let attacks = propertyListRepresentation["attacks"] as? [NSDictionary],
              let items = propertyListRepresentation["items"] as? [NSDictionary],
              let stats = propertyListRepresentation["stats"] as? NSDictionary,
            let gold = propertyListRepresentation["gold"] as? Int else {
                return nil
        }
        
        var convertedAttacks: [Attack] = []
        for attackDict in attacks {
            if let convertedAttack = Attack(propertyListRepresentation: attackDict) {
                convertedAttacks.append(convertedAttack)
            }
        }
        
        var convertedItems: [Item] = []
        for itemDict in items {
            if let convertedItem = Item(propertyListRepresentation: itemDict) {
                convertedItems.append(convertedItem)
            }
        }
        
        guard let convertedStats = PlayerStats(propertyListRepresentation: stats) else { return nil }
        
        
        
        self = Player(displayName: displayName, uuid: uuid, attacks: convertedAttacks, items: convertedItems, stats: convertedStats, gold: gold)
    }
    
    func propertyListRepresentation() -> NSDictionary {
        
        let plistAttacks = attacks.map{$0.propertyListRepresentation()}
        let plistItems = items.map{$0.propertyListRepresentation()}
        let plistStats = stats.propertyListRepresentation()
        
        let dict: NSDictionary = [
            "displayName" : displayName,
            "uuid"        : uuid,
            "attacks"     : plistAttacks,
            "items"       : plistItems,
            "stats"       : plistStats,
            "gold"        : gold
        ]
        return dict
    }
    
}
