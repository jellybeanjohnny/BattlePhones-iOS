//
//  LobbyTableViewCell.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/17/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        backgroundImageView.isHighlighted = highlighted
        
    }
}
