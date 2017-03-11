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

    
    @IBOutlet weak var textField: UITextField!
    var websocketServer = WebSocket(url: URL(string: "ws://localhost:8080/")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connectToServer()
    }

    func connectToServer() {
        websocketServer.connect()
        websocketServer.delegate = self
    }
    
    deinit {
        websocketServer.disconnect(forceTimeout: 0)
        websocketServer.delegate = nil
    }
    

}

extension ViewController: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        let userinfo = ["username" : "Matt",
                        "uuid" : "1234abcd",
                        "eventType" : "playerJoined"]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userinfo, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            websocketServer.write(string: jsonString)
        } catch {
            print(error.localizedDescription)
        }
        
        

    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {

    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        
    }
    
}

