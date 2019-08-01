//
//  Advertisement.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 2..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Advertisement: Object {
    @objc dynamic var adWorshipID: String = ""
    @objc dynamic var advertisementID: Int = 0
    @objc dynamic var worshipID: String = ""
    @objc dynamic var title: String = "-"
    @objc dynamic var content: String = "-"
    @objc dynamic var order: Int = 0
    let ownerWorshipData = LinkingObjects(fromType: WholeWorshipData.self, property: "advertisements")
    
    convenience init(json: JSON) {
        self.init()
        
        self.advertisementID = json[Name.adID].intValue
        self.worshipID = json[Name.worshipID].stringValue
        self.adWorshipID = "\(worshipID)_\(advertisementID)"
        self.title = json[Name.title].stringValue
        self.content = json[Name.content].stringValue
        self.order = json[Name.order].intValue
    }
    
    override static func primaryKey() -> String? {
        return Name.adWorshipID
    }
}

extension Advertisement {
    struct Name {
        static let adWorshipID = "adWorshipID"
        static let worshipID = "worshipId"
        static let adID = "adId"
        static let title = "title"
        static let content = "content"
        static let order = "order"
    }
}
