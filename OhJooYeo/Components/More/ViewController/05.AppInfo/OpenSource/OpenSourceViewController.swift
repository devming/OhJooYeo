//
//  OpenSourceViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class OpenSourceViewController: BaseViewController {

    static let segueName = "opensourceSegue"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        tableView.layer.cornerRadius = 10.0
    }
}

extension OpenSourceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LIBRARYS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "opensourceCell") else { return UITableViewCell() }
        
        cell.textLabel?.text = LIBRARYS[indexPath.row]
        cell.textLabel?.textColor = UIColor.init(named: "labelPrimary")
        
        return cell
    }
    
    
}
