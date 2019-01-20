//
//  WorshipMainInfo+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WorshipDataDAO {
    static let shared = WorshipDataDAO()
    var worshipData: WorshipData?
    
    func initWorshipData(json: JSON, completionHandler: () -> Void) {
        self.worshipData = WorshipData(json: json)
        guard let worshipData = self.worshipData else {
            return
        }
        try? DbManager.shared.realm?.write {
            DbManager.shared.realm?.add(worshipData)
        }
        completionHandler()
    }
    
    func getResultAll() -> Results<WorshipData>? {
        return DbManager.shared.realm?.objects(WorshipData.self)
    }
    
    func getWorshipDataLastObject() -> WorshipData? {
        return DbManager.shared.realm?.objects(WorshipData.self).last
    }
}
