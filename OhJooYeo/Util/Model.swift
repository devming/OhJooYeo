//
//  Model.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 7. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Model {
    static var shared: Version?
}

extension Model {
    struct Version {
        var worship: Worship?
        var advertisements: [Advertisement]?
        var music: Music?
        var currentVersion: String
        var worshipDate: String
        
        init?(json: JSON) {
            if let worship = Worship(json: json[Name.worship]) {
                self.worship = worship
            } else {
                self.worship = nil
            }
            
            if let advertisementList = json[Name.advertisement].array {
                
                self.advertisements = [Advertisement]()
                
                for advertisementJson in advertisementList {
                    
                    guard let advertisement = Advertisement(json: advertisementJson) else {
                        return nil
                    }
                    self.advertisements?.append(advertisement)
                }
            } else {
                self.advertisements = nil
            }
            
            if let music = Music(json: json[Name.music]) {
                self.music = music
            } else {
                self.music = nil
            }
            
            if let currentVersion = json[Name.currentVersion].string {
                self.currentVersion = currentVersion
            } else {
                self.currentVersion = ""
            }
            
            if let worshipDate = json[Name.worshipDate].string {
                self.worshipDate = worshipDate
            } else {
                self.worshipDate = ""
            }
        }
    }
    
}

extension Model.Version {
    struct Name {
        static let worship = "worship"
        static let advertisement = "advertisement"
        static let music = "music"
        static let currentVersion = "currentVersion"
        static let worshipDate = "worshipDate"
    }
}
