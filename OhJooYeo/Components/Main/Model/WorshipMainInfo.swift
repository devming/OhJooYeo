//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

class WorshipMainInfo: Object, Decodable {
    @objc dynamic var mainPresenter: String?
    @objc dynamic var nextPresenter: NextPresenter? = nil
    var worshipOrderList = List<WorshipOrder>()
    var worshipId: String?
    var version: String?
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mainPresenter = try container.decode(String.self, forKey: .mainPresenter)
        self.nextPresenter = try container.decodeIfPresent(NextPresenter.self, forKey: .nextPresenter)
        let worshipOrders = try container.decodeIfPresent([WorshipOrder].self, forKey: .worshipOrderList) ?? [WorshipOrder()]
        self.worshipOrderList.append(objectsIn: worshipOrders)
        
        self.worshipId = WorshipManager.shared.currentWorshipInfo?.worshipId
    }
    
    override static func primaryKey() -> String? {
        return CodingKeys.worshipId.rawValue
    }
    
    enum CodingKeys: String, CodingKey {
        case worshipId = "worshipID"
        case mainPresenter = "mainPresenter"
        case nextPresenter = "nextPresenter"
        case worshipOrderList = "worshipOrder"
        case worshipDate = "worshipDate"
    }
}
