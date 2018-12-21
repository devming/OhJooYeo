//
//  WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 1..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Model {}
extension Model {
    struct WorshipIdDate {
        var date: String
        var worshipId: String
        var version: String
        
        var worshipVersion: String
        var advertisementVersion: String
        var musicVersion: String
    
        init?(json: JSON) {
            if let date = json[Name.date].string {
                self.date = date
            } else {
                self.date = ConstantString.emptyString
            }
            
            if let worshipId = json[Name.worshipId].string {
                self.worshipId = worshipId
            } else {
                self.worshipId = ConstantString.emptyString
            }
            
            if let version = json[Name.version].string {
                self.version = version
            } else {
                self.version = ConstantString.notSetVersions
            }
            
            self.worshipVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 0)])"
            self.advertisementVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 1)])"
            self.musicVersion = "\(self.version[self.version.index(self.version.startIndex, offsetBy: 2)])"
        }
    }
}

extension Model.WorshipIdDate {
    struct Name {
        static let date = "worshipDate"
        static let worshipId = "worshipId"
        static let version = "version"
    }
}

