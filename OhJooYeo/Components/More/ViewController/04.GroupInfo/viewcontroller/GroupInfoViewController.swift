//
//  GroupInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class GroupInfoViewController: UIViewController {

    static let segueName = "groupInfoSegue"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
