//
//  PropertyListConvertible.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/16/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

/// Provides an interface for converting Swift structs to and from NSDictionary representations
protocol PropertyListConvertible {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation: NSDictionary)
}
