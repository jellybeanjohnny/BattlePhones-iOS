//
//  BattleViewController.swift
//  BattlePhones-iOS
//
//  Created by Matt Amerige on 3/23/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    @IBOutlet weak var dialogTableView: UITableView!
    

    convenience init() {
        self.init(nibName: String(describing: BattleViewController.self), bundle: Bundle.main)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        dialogTableView.delegate = self
        dialogTableView.dataSource = self
    }
}

extension BattleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // stub
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}

extension BattleViewController: UITableViewDelegate {
    
}

