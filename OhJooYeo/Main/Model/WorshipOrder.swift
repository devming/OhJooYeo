//
//  Order.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class WorshipOrder: Object {
    @objc dynamic var worshipOrderID: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var presenter: String = ""
    @objc dynamic var order: Int = 0
    @objc dynamic var orderID: Int = 0
    @objc dynamic var type: Int = 0
    let ownerWorship = LinkingObjects(fromType: WorshipMainInfo.self, property: "worshipOrders")
    
    convenience init(json: JSON, worshipID: String) {
        self.init()
        self.title = json[Name.title].stringValue
        self.detail = json[Name.detail].stringValue
        self.presenter = json[Name.presenter].stringValue
        self.order = json[Name.order].intValue
        self.orderID = json[Name.orderID].intValue
        self.type = json[Name.type].intValue
        self.worshipOrderID = "\(worshipID)_\(self.orderID)"
    }
    
    override static func primaryKey() -> String? {
        return Name.worshipOrderID
    }
}

extension WorshipOrder {
    struct Name {
        static let worshipOrderID = "worshipOrderID"
        static let title = "title"
        static let detail = "detail"
        static let presenter = "presenter"
        static let order = "order"
        static let orderID = "orderId"
        static let type = "type"
    }
    
    enum TypeName: Int {
        case normal = 0
        case phrase = 1
        case music = 2
    }
}

