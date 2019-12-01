//
//  UtilFunction.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

typealias UINavigationController = FullScreenModalNavigationController

func showConfirmationAlert(alertTitle title: String, alertMessage message: String, viewController vc: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    vc.present(alertController, animated: true, completion: nil)
}

//func loginCompletionHandler(completionHandler: @escaping () -> Void) {
//    App.loadAllDataFromServer {
//        App.isLoadingComplete = true
//        NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
//        completionHandler()
//    }
//}

//func setTransparentBackground(navigationController: UINavigationController?) {
//    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    navigationController?.navigationBar.shadowImage = UIImage()
//    navigationController?.navigationBar.isTranslucent = true
//    navigationController?.view.backgroundColor = .clear
//}

func callInitialAPI() {
//    if let infoDic: [String: Any] = Bundle.main.infoDictionary {
//        if let nMapClientID: String = infoDic["NMFClientId"] as? String {
//            print("## id: \(nMapClientID)")
//            NMFAuthManager.shared().clientId = nMapClientID
//        }
//    }
}

func showDate(worshipDate: String) -> String {
    let dateComponentString = worshipDate.split(separator: "-")
    var components = DateComponents()
    components.year = Int(dateComponentString[dateComponentString.index(0, offsetBy: 0)])
    components.month = Int(dateComponentString[dateComponentString.index(1, offsetBy: 0)])
    components.day = Int(dateComponentString[dateComponentString.index(2, offsetBy: 0)])
    
    guard let year = components.year, let month = components.month, let day = components.day else {
        return "\(worshipDate)"
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "ko-KR")
    guard let date = formatter.date(from: worshipDate) else {
        return "\(worshipDate)"
    }
    
    return "제 \(year-1982)권 \(formatter.calendar.component(.weekOfYear, from: date))호 \(year)년 \(month)월 \(day)일"
}
