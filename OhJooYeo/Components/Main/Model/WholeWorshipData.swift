//
//  WorshipData.swift
//  OhJooYeo
//
//  Created by Minki on 22/12/2018.
//  Copyright © 2018 devming. All rights reserved.
//

//import RealmSwift
//import SwiftyJSON
//
//final class WholeWorshipData: Object {
//    @objc dynamic var worshipMainInfo: WorshipMainInfo? = nil
//    @objc dynamic var worshipDate: String = ""
//    @objc dynamic var worshipID: String = ""
//    let advertisements = List<Advertisement>()
//    let musics = List<Music>()
//    
//    convenience init(json: JSON, worshipID: String) {
//        self.init()
//        self.worshipMainInfo = WorshipMainInfo(json: json[Name.worship], worshipID: worshipID)
//        self.worshipDate = json[Name.worshipDate].stringValue
//        self.worshipID = worshipID
//        
//        for advertisementData in json[Name.advertisement].arrayValue {
//            let advertisement = Advertisement(json: advertisementData)
//            if advertisement.content == "" {
//                continue
//            }
//            self.advertisements.append(advertisement)
//        }
//        for musicData in json[Name.musics].arrayValue {
//            self.musics.append(Music(json: musicData))
//        }
//    }
//    
//    override static func primaryKey() -> String? {
//        return Name.worshipID
//    }
//}
//
//extension WholeWorshipData {
//    struct Name {
//        static let worship = "worship"
//        static let worshipID = "worshipID"
//        static let worshipDate = "worshipDate"
//        static let advertisement = "advertisement"
//        static let musics = "musics"
//    }
//}
