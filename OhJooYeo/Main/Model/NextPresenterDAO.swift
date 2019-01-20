//
//  NextPresenterDAO.swift
//  OhJooYeo
//
//  Created by Minki on 19/01/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class NextPresenterDAO {
    static let shared = NextPresenterDAO()
    
    func getResultAll() -> Results<WorshipOrder>? {
        return DbManager.shared.realm?.objects(WorshipOrder.self)
    }
}
