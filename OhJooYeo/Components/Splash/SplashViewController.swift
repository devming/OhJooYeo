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
        
        Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: false)
        
         // Do any additional setup after loading the view.
        
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "main") as? UITabBarController {
//            present(vc, animated: true, completion: nil)
//        }
//        performSegue(withIdentifier: "main", sender: self)
        
//        if UserDefaults.standard.bool(forKey: "isLogin") {
//            performSegue(withIdentifier: "signin", sender: self)
//        } else {
//            performSegue(withIdentifier: "main", sender: self)
//        }
    }

    @objc func nextScreen() {
        
        var vcIdentifier = "signin"
        /// - TODO: []아래 조건문에 ! 빼고 isLogined를 로그인 했을대 설정하도록 할것
        if !UserDefaults.standard.bool(forKey: "isLogined") {
            vcIdentifier = "main"

            let vc =
                self.storyboard?.instantiateViewController(withIdentifier: vcIdentifier) as! UITabBarController
//            vc.modalPresentationStyle = .fullScreen
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
            
            return
        }
        let signinStoryBoard = UIStoryboard.init(name: "SignIn", bundle: nil)
        
        let vc =
            signinStoryBoard.instantiateViewController(withIdentifier: vcIdentifier) as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
