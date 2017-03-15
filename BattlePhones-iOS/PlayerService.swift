//
//  PlayerService.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/14/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PlayerService {
    
    static func saveNewPlayer(withDisplayName displayName: String, uuid: String, success: @escaping () -> Void, failure: @escaping () -> Void) {
        
        let urlString = Routes.builder(usingBase: .baseHTTP, path: .player)
        let parameters = ["displayName" : displayName, "uuid" : uuid]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
//                //TODO: Parse data for returned player object
//                if let data = response.data,
//                    let json = String(data: data, encoding: String.Encoding.utf8),
//                    let code = response.response?.statusCode {
//                    print("Code: \(code), Response: \(json)")
//                }
                success()
            case .failure(_):
                failure()
            }
            

        }
        
    }
}
