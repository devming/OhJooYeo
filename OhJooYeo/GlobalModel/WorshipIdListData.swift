//
//  WorshipIdListData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

final class WorshipIdListData {
    
    static var shared = WorshipIdListData()
    var worshipIdDate: [Model.WorshipIdDate]?
    
    private init() {}
    
    func setWorshipIdList(idList: [JSON]?) {
        guard let idList = idList else {
            return
        }
        
        self.worshipIdDate = [Model.WorshipIdDate]()
        for worshipId in idList {
            guard let worship = Model.WorshipIdDate(json: worshipId) else {
                continue
            }
            self.worshipIdDate?.append(worship)
        }
    }
    
}
