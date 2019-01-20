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
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var order: Int = -1
    let ownerWorshipData = LinkingObjects(fromType: WorshipData.self, property: "advertisements")
    
    convenience init(json: JSON) {
        self.init()
    }
//    init(title: String, content: String, order: Int) {
//        self.title = title
//        self.content = content
//        self.order = order
//    }
//
//    init?(json: JSON) {
//        if let title = json[Name.title].string {
//            self.title = title
//        } else {
//            self.title = "기타"
//        }
//
//        guard let content = json[Name.content].string else {
//            return nil
//        }
//        self.content = content
//
//        guard let order = json[Name.order].int else {
//            return nil
//        }
//        self.order = order
//    }
}

extension Advertisement {
    struct Name {
        static let title = "title"
        static let content = "content"
        static let order = "order"
    }
}
