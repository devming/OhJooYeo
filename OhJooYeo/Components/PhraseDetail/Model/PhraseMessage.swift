//
//  PhraseMessage.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 27..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class PhraseMessage: Decodable {
//    @objc dynamic var messageId: String?
    var phraseKey: String?
    var contents: String?
    
//    var primaryKey: String?
    var worshipId: String?
    
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.messageId = try container.decode(String.self, forKey: .messageId)
        self.phraseKey = try container.decodeIfPresent(String.self, forKey: .phraseKey)
        self.contents = try container.decodeIfPresent(String.self, forKey: .contents)
        
        self.worshipId = WorshipManager.shared.currentWorshipId
//        self.primaryKey = "\(String(describing: self.worshipId))_\(String(describing: messageId))"
    }
    
//    override static func primaryKey() -> String? {
//        return CodingKeys.primaryKey.rawValue
//    }
    
    enum CodingKeys: String, CodingKey {
//        case primaryKey = "primaryKey"
//        case messageId = "messageId"
        case phraseKey = "phrase"
        case contents = "contents"
    }
}
