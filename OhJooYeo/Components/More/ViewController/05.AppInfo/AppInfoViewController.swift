//
//  AppInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 20/07/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {

    static let segueName = "appInfoSegue"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.layer.cornerRadius = 10.0
    }
}

extension AppInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "") else { return UITableViewCell() }
        
        return cell
    }
    
    
}
