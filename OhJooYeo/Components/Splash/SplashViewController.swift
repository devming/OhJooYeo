//
//  SplashViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2019/12/01.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: BaseViewController {

    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch(withExpirationDuration: 3600) { [weak self] (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                if let appVersion = self?.remoteConfig[FirebaseRemoteKey.APP_VERSION].stringValue {
                    UserDefaults.standard.set(appVersion, forKey: FirebaseRemoteKey.APP_VERSION)
                }
//                self?.remoteConfig.activate(completionHandler: { (error) in
//                    if let error = error {
//                        print("error: \(error)")
//                        return
//                    }
//
//                })
                print("\(self?.remoteConfig[FirebaseRemoteKey.APP_VERSION].stringValue)")
            } else {
                print("Config not fetched")
            }
        }
        
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: false)
    }

    @objc func nextScreen() {
        /// - TODO: []아래 조건문에 ! 빼고 isLogined를 로그인 했을대 설정하도록 할것
        let vcIdentifier = !UserDefaults.standard.bool(forKey: "isLogined") ? SegueName.main.rawValue : SegueName.signin.rawValue
        
        performSegue(withIdentifier: vcIdentifier, sender: nil)
    }
}
