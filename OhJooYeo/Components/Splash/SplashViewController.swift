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
        
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: false)
    }

    @objc func nextScreen() {
        /// - TODO: []아래 조건문에 ! 빼고 isLogined를 로그인 했을대 설정하도록 할것
        let vcIdentifier = !UserDefaults.standard.bool(forKey: "isLogined") ? SegueName.main.rawValue : SegueName.signin.rawValue
        
        performSegue(withIdentifier: vcIdentifier, sender: nil)
    }
}
