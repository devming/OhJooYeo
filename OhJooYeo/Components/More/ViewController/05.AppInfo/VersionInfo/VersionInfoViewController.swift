//
//  VersionInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class VersionInfoViewController: UIViewController {
    
    static let segueName = "versionInfoSegue"
    @IBOutlet weak var versionInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionInfoLabel.text = "Version: \(APP_VERSION)"
    }
}
