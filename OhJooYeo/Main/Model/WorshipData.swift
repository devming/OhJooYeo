//
//  WorshipData.swift
//  OhJooYeo
//
//  Created by Minki on 22/12/2018.
//  Copyright © 2018 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WorshipData: Object {
    @objc dynamic var worshipMainInfo: WorshipMainInfo? = nil
    @objc dynamic var worshipDate: String = ""
    let advertisements = List<Advertisement>()
    let musics = List<Music>()
    
    convenience init(json: JSON) {
        self.init()
        self.worshipMainInfo = WorshipMainInfo(json: json[Name.worship])
        self.worshipDate = json[Name.worshipDate].stringValue
        
        for advertisementData in json[Name.advertisements].arrayValue {
            self.advertisements.append(Advertisement(json: advertisementData))
        }
        for musicData in json[Name.musics].arrayValue {
            self.musics.append(Music(json: musicData))
        }
    }
}

extension WorshipData {
    struct Name {
        static let worship = "worship"
        static let worshipDate = "worshipDate"
        static let advertisements = "advertisements"
        static let musics = "musics"
    }
}
