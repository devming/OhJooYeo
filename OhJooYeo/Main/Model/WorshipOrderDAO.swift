//
//  WorshipOrder+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 15..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WorshipOrderDAO {
    static let shared = WorshipOrderDAO()
    
    func getResultAll() -> Results<WorshipOrder>? {
        return DbManager.shared.realm?.objects(WorshipOrder.self)
    }
}
