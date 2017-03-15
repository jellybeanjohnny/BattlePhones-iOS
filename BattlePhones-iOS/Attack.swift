//
//  Attack.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Attack {
    let name: String
    let damageOutput: Float
    let energyCost: Float
    let actionDescription: String
    
    var description: String {
        return "name: \(name)\ndamageOutput: \(damageOutput)\nenergyCost: \(energyCost)\nactionDescription: \(actionDescription)"
    }
}

extension Attack {
    static func convert(usingJson playerJSON: JSON) -> [Attack] {
        var attacks: [Attack] = []
        for attackJSON in playerJSON["attacks"].arrayValue {
            let energyCost = attackJSON["energyCost"].floatValue
            let damageOutput = attackJSON["damageOutput"].floatValue
            let name = attackJSON["name"].stringValue
            let actionDescription = attackJSON["actionDescription"].stringValue
            let attack = Attack(name: name, damageOutput: damageOutput, energyCost: energyCost, actionDescription: actionDescription)
            attacks.append(attack)
        }
        return attacks
    }
}
