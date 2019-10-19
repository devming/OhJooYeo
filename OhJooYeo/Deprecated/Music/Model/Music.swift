//
//  Music.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 7. 14..
//  Copyright © 2018년 devming. All rights reserved.
//

//import RealmSwift
//import SwiftyJSON
//
//class Music: Object {
//    @objc dynamic var worshipID: String = ""
//    @objc dynamic var imageName: String = ""
//    @objc dynamic var lyricist: String = ""
//    @objc dynamic var composer: String = ""
//    @objc dynamic var title: String = ""
//    @objc dynamic var category: String = ""
//    @objc dynamic var order: Int = -1
//    let ownerWorshipData = LinkingObjects(fromType: WholeWorshipData.self, property: "musics")
//    
//    convenience init(json: JSON) {
//        self.init()
//    }
//    
//    override static func primaryKey() -> String? {
//        return "worshipID"
//    }
//}
//
//
//extension Music {
//    struct Name {
//        static let worshipID = "worshipID"
//        static let imageName = "imageName"
//        static let lyricist = "lyricist"
//        static let title = "title"
//        static let order = "order"
//        static let composer = "composer"
//        static let category = "category"
//        static let lylics = "lylics"
//    }
//}
