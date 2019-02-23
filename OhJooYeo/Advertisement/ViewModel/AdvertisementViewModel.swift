//
//  AdvertisementCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

final class AdvertisementViewModel {
    static var shared = AdvertisementViewModel()
    var advertisements: List<Advertisement>?
    
    private init() {
        self.advertisements = WholeWorshipDataDAO.shared.worshipData?.advertisements
    }
    
}
