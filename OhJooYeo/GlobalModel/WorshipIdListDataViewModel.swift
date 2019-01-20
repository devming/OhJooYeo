//
//  WorshipIdListData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WorshipIdListDataViewModel {
    
    static var shared = WorshipIdListDataViewModel()
    var worshipIdDate: [WorshipIdDate]?
    
    private init() {}
    
    func setWorshipIdList(idList: [JSON]?) {
//        guard let idList = idList else {
//            return
//        }
//
//        self.worshipIdDate = [WorshipIdDate]()
//        for worshipId in idList {
//            guard let worship = WorshipIdDate(json: worshipId) else {
//                continue
//            }
//            self.worshipIdDate?.append(worship)
//        }
    }
    
}
