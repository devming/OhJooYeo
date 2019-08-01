//
//  App.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

struct App {
    static var api: API = APIService()
    
    static var isLoadingComplete = false
    static func loadAllDataFromServer(completionHandler: @escaping () -> Void) {
        App.api.getWorshipIDList { isUpdated, willTakeIDVersionData in
            if let idVersionData = willTakeIDVersionData, isUpdated {
                App.api.getRecentDatas(worshipIDVersion: idVersionData) {
                    WorshipMainInfoViewModel.shared.setDate()
                    completionHandler()
                }
            } else {
                WorshipMainInfoViewModel.shared.setDate()
                completionHandler()
            }
        }
    }
}
