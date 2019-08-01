//
//  UtilFunction.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

func showConfirmationAlert(alertTitle title: String, alertMessage message: String, viewController vc: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    vc.present(alertController, animated: true, completion: nil)
}

func loginCompletionHandler(completionHandler: @escaping () -> Void) {
    App.loadAllDataFromServer {
        App.isLoadingComplete = true
        NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
        completionHandler()
    }
}

func setTransparentBackground(navigationController: UINavigationController?) {
    let gradientLayer = CAGradientLayer()
    
    if let navigationController = navigationController {
        gradientLayer.frame = navigationController.navigationBar.frame
    }
    //        // Render the gradient to UIImage
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    guard let context = UIGraphicsGetCurrentContext() else {
        UIGraphicsEndImageContext()
        return
    }
    gradientLayer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    navigationController?.navigationBar.setBackgroundImage(image, for: .default)
}

func callInitialAPI() {
//    if let infoDic: [String: Any] = Bundle.main.infoDictionary {
//        if let nMapClientID: String = infoDic["NMFClientId"] as? String {
//            print("## id: \(nMapClientID)")
//            NMFAuthManager.shared().clientId = nMapClientID
//        }
//    }
}


