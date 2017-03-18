//
//  PropertyListConvertible.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/16/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
// http://isame7.github.io/blog/2016/03/16/persisting-structs-in-swift/

import Foundation

/// Provides an interface for converting Swift structs to and from NSDictionary representations
protocol PropertyListConvertible {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation: NSDictionary)
}
