//
//  ViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/10/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit
import Starscream
import Alamofire

class ViewController: UIViewController {

    static let localhostURLString = "http://localhost:8080/player"
    static let localhostWebSocketServer = "ws://localhost:8080/"
    static let herokuWebSocketServer = "ws://battlephones-server.herokuapp.com/"
    
    @IBOutlet weak var textField: UITextField!
    var websocketServer = WebSocket(url: URL(string: ViewController.localhostWebSocketServer)!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        connectToServer()
        loadCloudKitID()
    }
    
    
    func loadCloudKitID() {
        let manager = CloudKitManager()
        manager.loadCloudKitID { [unowned self] (cloudKitID, error) in
            if let error = error {
                switch error {
                case .notAuthenticated: self.showAlert(title: "Uh oh!", message: "You're not signed into iCloud. Please go to Settings and sign in to your iCloud Account.")
                case .other: self.showAlert(title: "Uh oh!", message: "Something went wrong! Please try again")
                }
            } else if let cloudKitID = cloudKitID {
                self.registerPlayerWithID(id: cloudKitID)
            }
        }
    }

    func connectToServer() {
        websocketServer.connect()
        websocketServer.delegate = self
    }
    
    deinit {
        websocketServer.disconnect(forceTimeout: 0)
        websocketServer.delegate = nil
    }
    
    func registerPlayerWithID(id: String) {
        let parameters = [
            "displayName" : "Matt",
            "uuid" : id
        ]
        
        Alamofire.request(ViewController.localhostURLString, method: .post, parameters: parameters).responseJSON { (response) in
            if let data = response.data,
                let json = String(data: data, encoding: String.Encoding.utf8),
                let code = response.response?.statusCode {
                print("Code: \(code), Response: \(json)")
            }
        }
        
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
        print(text)
    }
    
}

