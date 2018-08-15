//
//  Model.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 7. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Model {}

extension Model {
    struct Version {
        var worship: Worship
        var advertisements: [Advertisement]
        var music: Music?
        var currentVersion: String
        
        init?(json: JSON) {
            guard let worship = Worship(json: json["worship"]) else {
                return nil
            }
            self.worship = worship
            
            guard let advertisementList = json["advertisement"].array else {
                return nil
            }
            
            self.advertisements = [Advertisement]()
            
            for advertisementJson in advertisementList {
                
                guard let advertisement = Advertisement(json: advertisementJson) else {
                    return nil
                }
                self.advertisements.append(advertisement)
            }
            
            if let music = Music(json: json["music"]) {
                self.music = music
            }
            
            guard let currentVersion = json["currentVersion"].string else {
                return nil
            }
            self.currentVersion = currentVersion
        }
    }
}
