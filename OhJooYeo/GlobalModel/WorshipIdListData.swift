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
    var worshipIdList: [Model.WorshipIdDate]?
    
    private init() {}
    
    func setWorshipIdList(idList: [JSON]?) {
        guard let idList = idList else {
            return
        }
        
        worshipIdList = [Model.WorshipIdDate]()
        for worshipId in idList {
            guard let worship = Model.WorshipIdDate(json: worshipId) else {
                continue
            }
            worshipIdList?.append(worship)
        }
    }
    
}
