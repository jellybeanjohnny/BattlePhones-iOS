//
//  BattleManager.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 4/21/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

/**
 The Battle manager handles sending and receiving attacks and other interactions that take place during a battle.
 
 */

protocol BatteManagerDelegate: class {
}

struct BattleManager {
    
    let opponentUUID: String
    
    /// Sends attack to the server to be processed
    func sendAttack(_ attack: Attack) {
        
    }
    
    
    
    
}
