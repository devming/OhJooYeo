//
//  UtilFunction.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import Foundation

func showConfirmationAlert(alertTitle title: String, alertMessage message: String, viewController vc: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    vc.present(alertController, animated: true, completion: nil)
}
