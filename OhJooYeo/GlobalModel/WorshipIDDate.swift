//
//  WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 1..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON


class WorshipIDDate: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var worshipID: String = ""
    @objc dynamic var version: String = "***"
    
    @objc dynamic var worshipVersion: String = "*"
    @objc dynamic var advertisementVersion: String = "*"
    @objc dynamic var musicVersion: String = "*"
    
    convenience init(json: JSON) {
        self.init()
        
        self.date = json[Name.date].stringValue
        self.worshipID = json[Name.worshipId].stringValue
        self.version = json[Name.version].stringValue
        self.worshipVersion = "\(self.version[self.version.startIndex])"
        self.advertisementVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 1)])"
        self.musicVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 2)])"
    }
}


extension WorshipIDDate {
    struct Name {
        static let date = "worshipDate"
        static let worshipId = "worshipId"
        static let version = "version"
    }
}

