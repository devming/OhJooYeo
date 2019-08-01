//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class WorshipMainInfo: Object {
    @objc dynamic var worshipID: String = ""
    @objc dynamic var mainPresenter: String = ""
    @objc dynamic var nextPresenter: NextPresenter? = nil
    let worshipOrders = List<WorshipOrder>()
    let ownerWorshipData = LinkingObjects(fromType: WholeWorshipData.self, property: "worshipMainInfo")
    
    convenience init(json: JSON, worshipID: String) {
        self.init()
        
        self.worshipID = worshipID
        
        self.mainPresenter = json[Name.mainPresenter].stringValue
        self.nextPresenter = NextPresenter(json: json[Name.nextPresenter], worshipID: worshipID)
        
        for worshipOrderData in json[Name.worshipOrder].arrayValue {
            self.worshipOrders.append(WorshipOrder(json: worshipOrderData, worshipID: worshipID))
        }
    }
    
    override static func primaryKey() -> String? {
        return Name.worshipID
    }
}

extension WorshipMainInfo {
    struct Name {
        static let worshipID = "worshipID"
        static let mainPresenter = "mainPresenter"
        static let nextPresenter = "nextPresenter"
        static let worshipOrder = "worshipOrder"
        static let worshipDate = "worshipDate"
    }
}
