//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Model {
    struct Worship {
        var mainPresenter: String
        var nextPresenter: NextPresenter
        var worshipOrders: [WorshipOrder]
        var currentVersion: String
        var worshipDate: String
        var worshipId: String
        var advertisements: [Advertisement]?
        var music: Music?
        
        struct NextPresenter {
            var mainPresenter: String
            var prayer: String
            var offer: String
            
            init(mainPresenter: String, prayer: String, offer: String) {
                self.mainPresenter = mainPresenter
                self.prayer = prayer
                self.offer = offer
            }
            
            init?(json: JSON) {
                guard let mainPresenter = json[Name.mainPresenter].string else {
                    return nil
                }
                self.mainPresenter = mainPresenter
                
                guard let prayer = json[Name.prayer].string else {
                    return nil
                }
                self.prayer = prayer
                
                guard let offer = json[Name.offer].string else {
                    return nil
                }
                self.offer = offer
            }
            
            struct Name {
                static let mainPresenter = "mainPresenter"
                static let prayer = "prayer"
                static let offer = "offer"
            }
        }
        
        init?(json: JSON) {
            guard let mainPresenter = json[Name.mainPresenter].string else {
                return nil
            }
            self.mainPresenter = mainPresenter
            
            guard let nextPresenter = NextPresenter(json: json[Name.nextPresenter]) else {
                return nil
            }
            self.nextPresenter = nextPresenter
            
            guard let orderList = json[Name.worshipOrders].array else {
                return nil
            }
            
            self.worshipOrders = [WorshipOrder]()
            
            for orderJson in orderList {
                
                guard let order = WorshipOrder(json: orderJson) else {
                    return nil
                }
                self.worshipOrders.append(order)
            }
            
            if let currentVersion = json[Name.currentVersion].string {
                self.currentVersion = currentVersion
            } else {
                self.currentVersion = Model.Constant.emptyString
            }
            
            if let worshipDate = json[Name.worshipDate].string {
                self.worshipDate = worshipDate
            } else {
                self.worshipDate = Model.Constant.emptyString
            }
            
            if let worshipId = json[Name.worshipId].string {
                self.worshipId = worshipId
            } else {
                self.worshipId = Model.Constant.emptyString
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
                GlobalState.shared.version = currentVersion
            } else {
                GlobalState.shared.version = "***"
            }
        }
    }
}

extension Model.Worship {
    struct Name {
        static let mainPresenter = "mainPresenter"
        static let nextPresenter = "nextPresenter"
        static let worshipOrders = "worshipOrders"
        static let currentVersion = "currentVersion"
        static let worshipDate = "worshipDate"
        static let worshipId = "worshipId"
        static let advertisement = "advertisement"
        static let music = "music"
    }
}
