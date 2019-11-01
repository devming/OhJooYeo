//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

class WorshipMainInfo: Decodable {
    var mainPresenter: String?
    var nextPresenter: NextPresenter? = nil
    var worshipOrderList: [WorshipOrder] = []// = [WorshipOrder]()
    var worshipId: String?
    var version: Int?
    
    public required convenience init(from decoder: Decoder) throws {
//        self.init(from: deco)
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mainPresenter = try container.decode(String.self, forKey: .mainPresenter)
        self.nextPresenter = try container.decodeIfPresent(NextPresenter.self, forKey: .nextPresenter)
//        self.worshipOrderList = [WorshipOrder]()
//        try JSONDecoder().decode([WorshipOrder].self, from: $0)
        let orders = try container.decode([WorshipOrder].self, forKey: .worshipOrderList)
        self.version = try container.decode(Int.self, forKey: .version)
        self.worshipOrderList.append(contentsOf: orders) //?? [WorshipOrder()]
//        self.worshipOrderList.append(contentsOf: worshipOrders)
        
        self.worshipId = WorshipManager.shared.currentWorshipInfo?.worshipId
    }
    
//    override static func primaryKey() -> String? {
//        return "worshipId"
//    }
    
    enum CodingKeys: String, CodingKey {
        case mainPresenter = "mainPresenter"
        case nextPresenter = "nextPresenter"
        case worshipOrderList = "worshipOrder"
        case worshipDate = "worshipDate"
        case version = "version"
    }
}
