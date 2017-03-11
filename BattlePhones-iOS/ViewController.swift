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
        websocketServer.delegate = self
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        websocketServer.write(string: "Sendimg message from iOS Client")
    }


}

extension ViewController: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        socket.write(string: "Matt");
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        
    }
    
}

