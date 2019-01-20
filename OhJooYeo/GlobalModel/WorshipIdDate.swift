//
//  WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 1..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON


class WorshipIdDate: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var worshipId: String = ""
    @objc dynamic var version: String = "***"
    
    @objc dynamic var worshipVersion: String = "*"
    @objc dynamic var advertisementVersion: String = "*"
    @objc dynamic var musicVersion: String = "*"
    
    convenience init(json: JSON) {
        self.init()
        
        self.date = json[Name.date].stringValue
        self.worshipId = json[Name.worshipId].stringValue
        self.version = json[Name.version].stringValue
        self.worshipVersion = "\(self.version[self.version.startIndex])"
        self.advertisementVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 1)])"
        self.musicVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 2)])"
    }
    
//    init?(json: JSON) {
//        if let date = json[Name.date].string {
//            self.date = date
//        } else {
//            self.date = ConstantString.emptyString
//        }
//
//        if let worshipId = json[Name.worshipId].string {
//            self.worshipId = worshipId
//        } else {
//            self.worshipId = ConstantString.emptyString
//        }
//
//        if let version = json[Name.version].string {
//            self.version = version
//        } else {
//            self.version = ConstantString.notSetVersions
//        }
//
//        self.worshipVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 0)])"
//        self.advertisementVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 1)])"
//        self.musicVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 2)])"
//    }
}


extension WorshipIdDate {
    struct Name {
        static let date = "worshipDate"
        static let worshipId = "worshipId"
        static let version = "version"
    }
}

