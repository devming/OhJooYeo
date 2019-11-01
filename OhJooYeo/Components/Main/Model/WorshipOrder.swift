//
//  Order.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

//import RealmSwift
/**
 
 
 "title": "제목",
 "detail": "상세",
 "presenter": "발표자",
 "orderId": 1,
 "churchId": 1,
 "order": 1

*/
class WorshipOrder: Decodable {
    var title: String?
    var detail: String?
    var presenter: String?
    var order: Int = 0
    var orderId: Int = 0
//    var churchId: Int? = 0
//
    var type: Int? = 0
    var standUp: Int? = 0
    var isStandUp: Bool {
        return standUp == 1 ? true : false
    }
    
//    let ownerWorship = LinkingObjects(fromType: WorshipMainInfo.self, property: "worshipOrders")
    var worshipOrderId: String?
    
    var worshipId: String?

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
        self.presenter = try container.decodeIfPresent(String.self, forKey: .presenter)
        self.order = try container.decode(Int.self, forKey: .order)
        self.orderId = try container.decode(Int.self, forKey: .orderId)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
        self.standUp = try container.decodeIfPresent(Int.self, forKey: .standUp)
        
        self.worshipId = WorshipManager.shared.currentWorshipInfo?.worshipId
        self.worshipOrderId = "\(String(describing: self.worshipId))_\(self.orderId)"
    }

//    override static func primaryKey() -> String? {
//        return CodingKeys.worshipOrderId.rawValue
//    }
    
    enum TypeName: Int {
        case normal = 0
        case phrase = 1
        case music = 2
    }
    
//    enum StandUpType: Int {
//        case down = 0
//        case up = 1
//    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case detail = "detail"
        case presenter = "presenter"
        case order = "order"
        case orderId = "orderId"
        
        case type = "type"
        case standUp = "standupYn"
//        case worshipOrderId = "worshipOrderId"
    }
}
