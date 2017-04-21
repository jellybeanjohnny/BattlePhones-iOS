//
//  PlayerService.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/14/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Alamofire

struct PlayerService {
    
    static func saveNewPlayer(withDisplayName displayName: String, uuid: String, success: @escaping (Player) -> Void, failure: @escaping () -> Void) {
        
        let urlString = Routes.builder(usingBase: .ngrokHTTP, path: .player)
        let parameters = ["displayName" : displayName, "uuid" : uuid]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let player = JSONParser.parse(using: value)
                success(player)
            case .failure(let error):
                print(error.localizedDescription)
                failure()
            }
        }
    }
    

    
}
