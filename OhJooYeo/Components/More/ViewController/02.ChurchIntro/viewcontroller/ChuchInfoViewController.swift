//
//  ChurchInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class ChurchInfoViewController: UIViewController {

    static let segueName = "churchInfoSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
//        setTransparentBackground(navigationController: self.navigationController)
    }
}
