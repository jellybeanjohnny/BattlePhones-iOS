//
//  Item.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Item {
    
}

extension Item {
    static func convert(usingJSON playerJSON: JSON) -> [Item] {
        var items: [Item] = []
        for itemJSON in playerJSON["items"].arrayValue {
            //TODO: populate properties here
        }
        return items
    }
}
