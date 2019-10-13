//
//  Order.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

class WorshipOrder: Object, Decodable {
    @objc dynamic var title: String?
    @objc dynamic var detail: String?
    @objc dynamic var presenter: String?
    @objc dynamic var order: Int = 0
    @objc dynamic var orderID: Int = 0
    @objc dynamic var type: Int = 0
    let ownerWorship = LinkingObjects(fromType: WorshipMainInfo.self, property: "worshipOrders")
    @objc dynamic var worshipOrderID: String?
    
    @objc dynamic var worshipId: String?

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.detail = try container.decode(String.self, forKey: .detail)
        self.presenter = try container.decode(String.self, forKey: .presenter)
        self.order = try container.decode(Int.self, forKey: .order)
        self.orderID = try container.decode(Int.self, forKey: .orderID)
        self.type = try container.decode(Int.self, forKey: .type)
        self.worshipId = WorshipManager.shared.currentWorshipInfo?.worshipId
        self.worshipOrderID = "\(String(describing: self.worshipId))_\(self.orderID)"
    }
    
    override static func primaryKey() -> String? {
        return CodingKeys.worshipOrderID.rawValue
    }
    
    enum TypeName: Int {
        case normal = 0
        case phrase = 1
        case music = 2
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case detail = "detail"
        case presenter = "presenter"
        case order = "order"
        case orderID = "orderId"
        case type = "type"
        case worshipOrderID = "worshipOrderID"
    }
}
