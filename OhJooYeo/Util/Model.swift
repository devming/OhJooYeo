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
        var mainOrder: Worship
        var advertisements: [Advertisement]
        var music: Music?
        var currentVersion: String
        
        init?(json: JSON) {
            guard let mainOrder = Worship(json: json["mainOrder"]) else {
                return nil
            }
            self.mainOrder = mainOrder
            
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
            
            guard let music = Music(json: json["music"]) else {
                return nil
            }
            self.music = music
            
            guard let currentVersion = json["currentVersion"].string else {
                return nil
            }
            self.currentVersion = currentVersion
        }
    }
}
