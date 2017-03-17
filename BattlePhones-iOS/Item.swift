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
    let name: String
    let itemDescription: String
}

extension Item {
    static func convert(usingJSON playerJSON: JSON) -> [Item] {
        var items: [Item] = []
        for itemJSON in playerJSON["items"].arrayValue {
            //TODO: populate properties here
            let name = itemJSON["name"].stringValue
            let description = itemJSON["itemDescription"].stringValue
            let item = Item(name: name, itemDescription: description)
            items.append(item)
        }
        return items
    }
}

extension Item: PropertyListConvertible {
    init?(propertyListRepresentation: NSDictionary) {
        guard let name = propertyListRepresentation["name"] as? String,
            let description = propertyListRepresentation["itemDescription"] as? String else {
                return nil
        }
        self = Item(name: name, itemDescription: description)
    }
    
    func propertyListRepresentation() -> NSDictionary {
        let representation: NSDictionary = [
            "name" : name,
            "itemDescription" : itemDescription
        ]
        
        return representation
    }
}
