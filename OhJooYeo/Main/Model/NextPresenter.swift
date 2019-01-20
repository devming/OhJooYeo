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
    @objc dynamic var mainPresenter: String = ""
    @objc dynamic var prayer: String = ""
    @objc dynamic var offer: String = ""
    let ownerWorship = LinkingObjects(fromType: WorshipMainInfo.self, property: "nextPresenter")
    
    convenience init(json: JSON) {
        self.init()
        
        self.mainPresenter = json[Name.mainPresenter].stringValue
        self.prayer = json[Name.prayer].stringValue
        self.offer = json[Name.offer].stringValue
    }
//    init(mainPresenter: String, prayer: String, offer: String) {
//        self.mainPresenter = mainPresenter
//        self.prayer = prayer
//        self.offer = offer
//    }
//
//    init?(json: JSON) {
//        guard let mainPresenter = json[Name.mainPresenter].string else {
//            return nil
//        }
//        self.mainPresenter = mainPresenter
//
//        guard let prayer = json[Name.prayer].string else {
//            return nil
//        }
//        self.prayer = prayer
//
//        guard let offer = json[Name.offer].string else {
//            return nil
//        }
//        self.offer = offer
//    }
    
    struct Name {
        static let mainPresenter = "mainPresenter"
        static let prayer = "prayer"
        static let offer = "offer"
    }
}
