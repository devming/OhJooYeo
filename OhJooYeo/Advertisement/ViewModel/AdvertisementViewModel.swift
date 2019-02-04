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
    var worshipDataObject: WholeWorshipDataDAO
    var advertisements: List<Advertisement>?
    
    private init() {
        self.worshipDataObject = WholeWorshipDataDAO.shared
        self.advertisements = WholeWorshipDataDAO.shared.worshipData?.advertisements
    }
    
}
