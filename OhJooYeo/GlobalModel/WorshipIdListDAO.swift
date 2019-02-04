//
//  WorshipIdListDAO.swift
//  OhJooYeo
//
//  Created by Minki on 22/12/2018.
//  Copyright © 2018 devming. All rights reserved.
//

import SwiftyJSON
import RealmSwift

final class WorshipIDListDAO {
    static let shared = WorshipIDListDAO()
    var worshipIDDate: WorshipIDDate?
    var worshipIDDateList = [WorshipIDDate]()
    
    func initWorshipIDListDAO(json: JSON) {
        for worshipIdDate in json.arrayValue {
            self.worshipIDDate = WorshipIDDate(json: worshipIdDate)
            
            guard let worshipIdList = self.worshipIDDate else {
                continue
            }
            try? DbManager.shared.realm?.write {
                DbManager.shared.realm?.add(worshipIdList)
            }
            self.worshipIDDateList.append(worshipIdList)
        }
        
    }
}
