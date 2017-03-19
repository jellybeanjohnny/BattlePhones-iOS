//
//  LobbyViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/13/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    var lobbyViewModel = LobbyViewModel()
    
    @IBOutlet weak var tableView: UITableView!

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
        
        title = "Lobby"
        
        setDelegates()
        registerNibs()
        lobbyViewModel.viewDidLoad()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        lobbyViewModel.delegate = self
    }
    
    func registerNibs() {
        let cellNib = UINib(nibName: String(describing: LobbyTableViewCell.self), bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "LobbyCell")
    }
    
    @IBAction func joinButtonPressed(_ sender: Any) {
        lobbyViewModel.joinLobby()
    }
    
}

//MARK: - TableView
extension LobbyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbyViewModel.activePlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyCell", for: indexPath) as? LobbyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.displayNameLabel.text = lobbyViewModel.displayName(forRowAtIndexPath: indexPath)
        
        return cell
    }
}

extension LobbyViewController: UITableViewDelegate {
    
}

//MARK: - LobbyViewModel Delegate
extension LobbyViewController: LobbyViewModelDelegate {
    func refresh() {
        tableView.reloadData()
    }
}
