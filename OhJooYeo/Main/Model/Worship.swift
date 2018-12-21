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
        var musics: [Music]?
        var worshipDate: String
        var advertisements: [Advertisement]?
        
        var worshipJson: [String: JSON]?
        var mainPresenter: String
        var nextPresenter: NextPresenter?
        var worshipOrders: [WorshipOrder]
        
        init?(json: JSON) {
            self.worshipOrders = [WorshipOrder]()
            if let worshipJson = json[Name.worship].dictionary {
                self.worshipJson = worshipJson
                
                guard let mainPresenter = worshipJson[Name.mainPresenter]?.string else {
                    return nil
                }
                self.mainPresenter = mainPresenter
                
                guard let worshipJsonNextPresenter = worshipJson[Name.nextPresenter],
                    let nextPresenter = NextPresenter(json: worshipJsonNextPresenter) else {
                        return nil
                }
                self.nextPresenter = nextPresenter
                
                guard let orderList = worshipJson[Name.worshipOrder]?.array else {
                    return nil
                }
                
                
                for orderJson in orderList {
                    
                    guard let order = WorshipOrder(json: orderJson) else {
                        return nil
                    }
                    self.worshipOrders.append(order)
                }
            } else {
                self.worshipJson = nil
                self.nextPresenter = nil
                self.mainPresenter = "x"
            }
            
            
            
            if let worshipDate = json[Name.worshipDate].string {
                self.worshipDate = worshipDate
            } else {
                self.worshipDate = ConstantString.emptyString
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
            
            if let musicList = json[Name.music].array {
                
                self.musics = [Music]()
                
                for musicJson in musicList {
                    
                    guard let music = Music(json: musicJson) else {
                        return nil
                    }
                    self.musics?.append(music)
                }
            } else {
                self.musics = nil
            }
//            GlobalState.shared.version = self.currentVersion
        }
        
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
    }
}

extension Model.Worship {
    struct Name {
        static let worship = "worship"
        static let mainPresenter = "mainPresenter"
        static let nextPresenter = "nextPresenter"
        static let worshipOrder = "worshipOrder"
        static let worshipDate = "worshipDate"
        static let advertisement = "advertisement"
        static let music = "music"
    }
}
