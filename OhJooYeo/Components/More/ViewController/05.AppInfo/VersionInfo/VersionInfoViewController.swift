//
//  VersionInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import Firebase

class VersionInfoViewController: BaseViewController {
    
    static let segueName = "versionInfoSegue"
    @IBOutlet weak var versionInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if isUpdateAvailable() {
//            /// - TODO: [UI 반영] 업데이트 하기 위한 버튼 UI 제작
//        }
        versionInfoLabel.text = "Version: \(getCurrentVersion)"
    }
    
    var getCurrentVersion: String {
        get {
            guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return APP_VERSION }
            
            /// 이 코드는 나중에 강제 업데이트 할때 사용하자.
//            guard let version = UserDefaults.standard.string(forKey: FirebaseRemoteKey.APP_VERSION) else { return APP_VERSION }
            return version
        }
    }
}
