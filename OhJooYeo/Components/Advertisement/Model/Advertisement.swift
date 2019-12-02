//
//  Advertisement.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 2..
//  Copyright © 2018년 devming. All rights reserved.
//

class Advertisement: Decodable {
    
    var worshipId: String?
    var advertisementId: Int = 0
    var title: String = "-"
    var content: String = "-"
    var order: Int = 0
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.advertisementId = try container.decode(Int.self, forKey:  .advertisementId)
        self.worshipId = try container.decode(String.self, forKey: .worshipId)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.order = try container.decode(Int.self, forKey: .order)
    }
    
//    override static func primaryKey() -> String? {
//        return CodingKeys.adWorshipId.rawValue
//    }
        
    enum CodingKeys: String, CodingKey {
//        case adWorshipId = "adWorshipID"
        case worshipId = "worshipId"
        case advertisementId = "adId"
        case order = "order"
        case title = "title"
        case content = "content"
    }
}
