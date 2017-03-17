//
//  PlayerStats.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PlayerStats {
    var rank: Int
    var maxHealth: Float
    var maxEnergy: Float
    var currentHealth: Float
    var currentEnergy: Float
    var experiencePoints: Float
    
    var description: String {
        return "rank: \(rank)\nmaxHealth: \(maxHealth)\nmaxEnergy: \(maxEnergy)\ncurrentHealth: \(currentHealth)\ncurrentEnergy: \(currentEnergy)\nEXP: \(experiencePoints)"
    }
}


extension PlayerStats {
    
    static func convert(usingJSON playerJSON: JSON) -> PlayerStats {
        let rank = playerJSON["stats"]["rank"].intValue
        let maxHealth = playerJSON["stats"]["maxHealth"].floatValue
        let maxEnergy = playerJSON["stats"]["maxEnergy"].floatValue
        let currentHealth = playerJSON["stats"]["currentHealth"].floatValue
        let currentEnergy = playerJSON["stats"]["currentEnergy"].floatValue
        let experiencePoints = playerJSON["stats"]["experiencePoints"].floatValue
        let stats = PlayerStats(rank: rank,
                                maxHealth: maxHealth,
                                maxEnergy: maxEnergy,
                                currentHealth: currentHealth,
                                currentEnergy: currentEnergy,
                                experiencePoints: experiencePoints)
        return stats
    }
}

extension PlayerStats: PropertyListConvertible {
    init?(propertyListRepresentation: NSDictionary) {
        guard let rank = propertyListRepresentation["rank"] as? Int,
              let maxHealth = propertyListRepresentation["maxHealth"] as? Float,
              let maxEnergy = propertyListRepresentation["maxEnergy"] as? Float,
              let currentHealth = propertyListRepresentation["currentHealth"] as? Float,
              let currentEnergy = propertyListRepresentation["currentEnergy"] as? Float,
            let experiencePoints = propertyListRepresentation["experiencePoints"] as? Float else {
                return nil
        }
        self = PlayerStats(rank: rank, maxHealth: maxHealth, maxEnergy: maxEnergy, currentHealth: currentHealth, currentEnergy: currentEnergy, experiencePoints: experiencePoints)
    }
    
    func propertyListRepresentation() -> NSDictionary {
        let dict: NSDictionary = [
            "rank" : rank,
            "maxHealth" : maxHealth,
            "maxEnergy" : maxEnergy,
            "currentHealth" : currentHealth,
            "currentEnergy" : currentEnergy,
            "experiencePoints" : experiencePoints
        ]
        return dict
    }
}

