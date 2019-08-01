//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class WorshipMain: Object {
    @objc dynamic var mainPresenter: String = ""
    @objc dynamic var nextPresenter: NextPresenter? = nil
    let worshipOrders = List<WorshipOrder>()
    let ownerWorshipData = LinkingObjects(fromType: WorshipData.self, property: "worship")
    
    convenience init(json: JSON) {
        self.init()
        
        self.mainPresenter = json[Name.mainPresenter].stringValue
        self.nextPresenter = NextPresenter(json: json[Name.nextPresenter])
        
        for worshipOrderData in json[Name.worshipOrder].arrayValue {
            self.worshipOrders.append(WorshipOrder(json: worshipOrderData))
        }
    }
//    init?(json: JSON) {
//        if let worshipJson = json[Name.worship].dictionary {
//            self.worshipJson = worshipJson
//
//            guard let mainPresenter = worshipJson[Name.mainPresenter]?.string else {
//                return nil
//            }
//            self.mainPresenter = mainPresenter
//
//            guard let worshipJsonNextPresenter = worshipJson[Name.nextPresenter],
//                let nextPresenter = NextPresenter(json: worshipJsonNextPresenter) else {
//                    return nil
//            }
//            self.nextPresenter = nextPresenter
//
//            guard let orderList = worshipJson[Name.worshipOrder]?.array else {
//                return nil
//            }
//
//
//            for orderJson in orderList {
//
//                guard let order = WorshipOrder(json: orderJson) else {
//                    return nil
//                }
//                self.worshipOrders.append(order)
//            }
//        } else {
//            self.nextPresenter = nil
//            self.mainPresenter = "x"
//        }
//
//        if let worshipDate = json[Name.worshipDate].string {
//            self.worshipDate = worshipDate
//        } else {
//            self.worshipDate = ConstantString.emptyString
//        }
//
//
//        if let advertisementList = json[Name.advertisement].array {
//
//            self.advertisements = [Advertisement]()
//
//            for advertisementJson in advertisementList {
//
//                guard let advertisement = Advertisement(json: advertisementJson) else {
//                    return nil
//                }
//                self.advertisements?.append(advertisement)
//            }
//        } else {
//            self.advertisements = nil
//        }
//
//        if let musicList = json[Name.music].array {
//
//            self.musics = [Music]()
//
//            for musicJson in musicList {
//
//                guard let music = Music(json: musicJson) else {
//                    return nil
//                }
//                self.musics?.append(music)
//            }
//        } else {
//            self.musics = nil
//        }
//        //            GlobalState.shared.version = self.currentVersion
//    }
}

extension WorshipMain {
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
