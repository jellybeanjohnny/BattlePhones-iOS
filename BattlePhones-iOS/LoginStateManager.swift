//
//  LoginStateManager.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

struct LoginStateManager {
    
    static func shouldShowLoginScreen() -> Bool {
        // show the login screen if the user has not picked a displayname
        return UserDefaults.standard.string(forKey: "display_name") == nil
    }
    
}
