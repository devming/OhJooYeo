//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class NextPresenter: Object {
    @objc dynamic var worshipID: String = ""
    @objc dynamic var mainPresenter: String = ""
    @objc dynamic var prayer: String = ""
    @objc dynamic var offer: String = ""
    let ownerWorship = LinkingObjects(fromType: WorshipMainInfo.self, property: "nextPresenter")
    
    convenience init(json: JSON, worshipID: String) {
        self.init()
        
        self.worshipID = worshipID
        
        self.mainPresenter = json[Name.mainPresenter].stringValue
        self.prayer = json[Name.prayer].stringValue
        self.offer = json[Name.offer].stringValue
    }
    
    override static func primaryKey() -> String? {
        return Name.worshipID
    }
}

extension NextPresenter {
    struct Name {
        static let worshipID = "worshipID"
        static let mainPresenter = "mainPresenter"
        static let prayer = "prayer"
        static let offer = "offer"
    }
}
