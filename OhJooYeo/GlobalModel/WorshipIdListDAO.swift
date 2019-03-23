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
        self.worshipIDDateList.removeAll()
        for worshipIDDate in json.arrayValue {
            self.worshipIDDate = WorshipIDDate(json: worshipIDDate)

            guard let worshipIDDate = self.worshipIDDate else {
                continue
            }
            if GlobalState.shared.localVersion != worshipIDDate.version {
                try? DbManager.shared.realm?.write {
                    DbManager.shared.realm?.add(worshipIDDate, update: true)
                }
                self.worshipIDDateList.append(worshipIDDate)
            }
        }
    }
}
