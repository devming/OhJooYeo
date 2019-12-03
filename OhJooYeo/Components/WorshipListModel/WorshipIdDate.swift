//
//  WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 1..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

class WorshipIdDate: Decodable {
//    @objc dynamic var date: String = ""
//    @objc dynamic var worshipId: String = ""
    
    var date: String = ""
    var worshipId: String = ""
    var version: Int = 0
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.worshipId = try container.decode(String.self, forKey: .worshipId)
    }
        
//    override static func primaryKey() -> String? {
//        return CodingKeys.worshipId.rawValue
//    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case worshipId = "worshipId"
    }
}
