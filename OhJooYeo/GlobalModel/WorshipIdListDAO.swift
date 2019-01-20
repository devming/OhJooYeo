//
//  WorshipIdListDAO.swift
//  OhJooYeo
//
//  Created by Minki on 22/12/2018.
//  Copyright © 2018 devming. All rights reserved.
//

import SwiftyJSON
import RealmSwift

final class WorshipIdListDAO {
    static let shared = WorshipIdListDAO()
    var worshipIdDate: WorshipIdDate?
    var worshipIdDateList = [WorshipIdDate]()
    
    func initWorshipIdListDAO(json: JSON) {
        for worshipIdDate in json.arrayValue {
            self.worshipIdDate = WorshipIdDate(json: worshipIdDate)
            
            guard let worshipIdList = self.worshipIdDate else {
                continue
            }
            try? DbManager.shared.realm?.write {
                DbManager.shared.realm?.add(worshipIdList)
            }
            self.worshipIdDateList.append(worshipIdList)
        }
        
    }
}
