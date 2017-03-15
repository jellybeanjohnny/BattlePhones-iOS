//
//  CloudKitService.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import CloudKit

enum CloudKitError: Error {
    case notAuthenticated
    case other
}

struct CloudKitService {
    
    /// Loads the CloudKit ID if it exists, otherwise returns nil and an error. If the ID exists it is saved to user defaults
    static func loadCloudKitID(completion:@escaping (String?, CloudKitError?) -> Void) {
        
        // Load any cached id if available
        if let cloudKitID = UserDefaults.standard.object(forKey: "cloudkit_uuid_string") as? String {
            completion(cloudKitID, nil)
            return
        }
        
        // Load fresh id
        let container = CKContainer.default()
        container.fetchUserRecordID { (recordID, error) in
            
            if let error = error {
                if error._code == CKError.notAuthenticated.rawValue {
                    completion(nil, CloudKitError.notAuthenticated)
                } else {
                    completion(nil, CloudKitError.other)
                }
                return
            }
            
            // Save the id to defaults
            if let recordID = recordID {
                UserDefaults.standard.set(recordID.recordName, forKey: "cloudkit_uuid_string")
                completion(recordID.recordName, nil)
            }
        }
    }
    
}
