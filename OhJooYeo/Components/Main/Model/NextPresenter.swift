//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

class NextPresenter: Object, Decodable {
    @objc dynamic var mainPresenter: String = ""
    @objc dynamic var prayer: String = ""
    @objc dynamic var offer: String = ""
    let ownerWorship = LinkingObjects(fromType: WorshipMainInfo.self, property: "nextPresenter")
    @objc dynamic var worshipId: String?
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mainPresenter = try container.decode(String.self, forKey: .mainPresenter)
        self.prayer = try container.decode(String.self, forKey: .prayer)
        self.offer = try container.decode(String.self, forKey: .offer)
        
        self.worshipId = WorshipManager.shared.currentWorshipInfo?.worshipId
    }
    
    override static func primaryKey() -> String? {
        return CodingKeys.worshipId.rawValue
    }
    
    enum CodingKeys: String, CodingKey {
        case worshipId = "worshipID"
        case mainPresenter = "mainPresenter"
        case prayer = "prayer"
        case offer = "offer"
    }
}
