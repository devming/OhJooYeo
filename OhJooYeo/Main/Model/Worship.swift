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
                guard let mainPresenter = json["mainPresenter"].string else {
                    return nil
                }
                self.mainPresenter = mainPresenter
                
                guard let prayer = json["prayer"].string else {
                    return nil
                }
                self.prayer = prayer
                
                guard let offer = json["offer"].string else {
                    return nil
                }
                self.offer = offer
            }
        }
        
        init?(json: JSON) {
            guard let mainPresenter = json["mainPresenter"].string else {
                return nil
            }
            self.mainPresenter = mainPresenter
            
            guard let nextPresenter = NextPresenter(json: json["nextPresenter"]) else {
                return nil
            }
            self.nextPresenter = nextPresenter
            
            guard let orderList = json["worshipOrder"].array else {
                return nil
            }
            
            self.worshipOrders = [WorshipOrder]()
            
            for orderJson in orderList {
                
                guard let order = WorshipOrder(json: orderJson) else {
                    return nil
                }
                self.worshipOrders.append(order)
            }
        }
    }
}
