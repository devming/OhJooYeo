//
//  WorshipMainInfoDAO.swift
//  OhJooYeo
//
//  Created by Minki on 19/01/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WorshipMainInfoDAO {
    static let shared = WorshipMainInfoDAO()
    
    func getResultAll() -> Results<WorshipMainInfo>? {
        return DbManager.shared.realm?.objects(WorshipMainInfo.self)
    }
}

