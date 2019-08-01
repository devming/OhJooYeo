//
//  AppInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 20/07/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class AppInfoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}
