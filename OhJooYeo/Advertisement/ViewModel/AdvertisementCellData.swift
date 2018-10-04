//
//  AdvertisementCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

final class AdvertisementCellData {
    static var shared = AdvertisementCellData()
    var advertisements: [AdvertisementMO]?
    
    func setAdvertisement(advertisementModels: [Model.Advertisement]?) {
        guard let worshipMO = WorshipCellData.shared.worshipMO,
            let worshipVersion = worshipMO.version,
            let advertisementModels = advertisementModels else {
            return
        }
        
        let remoteWorshipVersion = worshipVersion[worshipVersion.index(worshipVersion.startIndex, offsetBy: 1)]
        
        let currentLocalVersion = GlobalState.shared.version
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 1)]
        //        remoteWorshipVersion = "d"
        if currentLocalWorshipVersion == ConstantString.notSetVersion { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
            DbManager.shared.addAdvertisement(advertisements: advertisementModels, worshipMO: worshipMO)
        } else if currentLocalWorshipVersion < remoteWorshipVersion { // 받아온 정보가 더 최신일 경우 - Update
            DbManager.shared.updateAdvertisement(advertisements: advertisementModels, worshipMO: worshipMO)
        }
        
        if let version = worshipMO.version {
            let advertisementVersion = version[version.index(version.startIndex, offsetBy: 1)]

            GlobalState.shared.version = "\(currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)])" + "\(advertisementVersion)" + "\(currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 2)])"  // 로컬을 원격 버전으로 교체
        }
        
        self.advertisements = DbManager.shared.getAdvertisementList(worshipId: worshipMO.worshipId)
        
        NotificationCenter.default.post(name: .AdvertisementDidUpdated, object: nil)
    }
}
