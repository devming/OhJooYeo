//
//  SignUpViewController.swift
//  OhJooYeo
//
//  Created by Minki on 18/05/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        setTransparentBackground(navigationController: self.navigationController)
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
