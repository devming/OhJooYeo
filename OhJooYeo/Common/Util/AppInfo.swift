//
//  AppInfo.swift
//  OhJooYeo
//
//  Created by Minki on 18/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

let APP_VERSION = "0.0.1"
let LIBRARYS = ["SwiftyJSON", "Alamofire-SwiftyJSON", "RealmSwift", "NVActivityIndicatorView", "RxAlamofire", "RxSwift", "RxCocoa", "NMapsMap"]

func isUpdateAvailable() -> Bool {
    
    guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.ohjooyeo.OhJooYeo"),
        let data = try? Data(contentsOf: url),
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
        let results = json?["results"] as? [[String: Any]], results.count > 0,
        let appStoreVersion = results[0]["version"] as? String else { return false }
            
    if version != appStoreVersion { return true }

    return false
}
