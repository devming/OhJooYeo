//
//  AdvertisementCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

final class AdvertisementViewModel {
    static var shared = AdvertisementViewModel()
    var advertisements: [AdvertisementMO]?
    
    func setAdvertisement(worshipMO: WorshipMO?) {
        guard let worshipMO = worshipMO else {
            return
        }
        
//        self.advertisements = DbManager.shared.getAdvertisementList(worshipId: worshipMO.worshipId)        
    }
}
