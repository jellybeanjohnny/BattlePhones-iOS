//
//  LobbyViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let dummyData = [
        "conspiracycrisp",
        "hossagain",
        "cabinetcorazon",
        "yellsharp",
        "elderflowerfits",
        "buyselladsyeoman",
        "cavaliertranslator",
        "worthlessodiferous",
        "attractbarrisdale",
        "friendlybed",
        "tenderriding",
        "molalitysamantha",
        "beckarain",
        "zoeacrid",
        "rackscuts",
        "butteredrafter",
        "beaconswatermelon",
        "unsmokedjasmine",
        "auditilmenite",
        "fillerpumlumon"
    ]
    
    convenience init() {
        self.init(nibName: String(describing: LobbyViewController.self), bundle: Bundle.main)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionManager.sharedInstance.connect()
        title = "Lobby"
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellNib = UINib(nibName: String(describing: LobbyTableViewCell.self), bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "LobbyCell")
    }
    
    @IBAction func joinButtonPressed(_ sender: Any) {
        ConnectionManager.sharedInstance.joinLobby()
    }
    
}

extension LobbyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyCell", for: indexPath) as? LobbyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.displayNameLabel.text = dummyData[indexPath.row]
        
        return cell
    }
}

extension LobbyViewController: UITableViewDelegate {
    
}
