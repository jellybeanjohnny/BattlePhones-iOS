//
//  ViewController+Alert.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
