//
//  ViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/10/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController {

    var websocketServer = WebSocket(url: URL(string: "ws://localhost:8080/")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connectToServer()
    }

    func connectToServer() {
        websocketServer.connect()
        
    }


}

