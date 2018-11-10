//
//  Order.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Model {
    struct WorshipOrder {
        var title: String
        var detail: String
        var presenter: String
        var order: Int
        var orderId: Int32
        var type: Int
        
        init(title: String, detail: String, presenter: String, order: Int, orderId: Int, type: Int) {
            self.title = title
            self.detail = detail
            self.presenter = presenter
            self.order = order
            self.orderId = Int32(orderId)
            self.type = type
        }
        
        init?(json: JSON) {
            guard let title = json[Name.title].string else {
                return nil
            }
            self.title = title
            
            if let detail = json[Name.detail].string {
                self.detail = detail
            } else {
                self.detail = ConstantString.emptyString
            }
            
            guard let presenter = json[Name.presenter].string else {
                return nil
            }
            self.presenter = presenter
            
            guard let order = json[Name.order].int else {
                return nil
            }
            self.order = order
            
            guard let orderId = json[Name.orderId].int else {
                return nil
            }
            self.orderId = Int32(orderId)
            
            guard let typeString = json[Name.type].string, let type = Int(typeString) else {
                return nil
            }
            self.type = type
        }
    }
}

extension Model.WorshipOrder {
    struct Name {
        static let title = "title"
        static let detail = "detail"
        static let presenter = "presenter"
        static let order = "order"
        static let orderId = "orderId"
        static let type = "type"
    }
    
    enum TypeName: Int32 {
        case normal = 0
        case phrase = 1
        case music = 2
    }
}

