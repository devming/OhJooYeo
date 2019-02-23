//
//  PhraseMessageSet.swift
//  OhJooYeo
//
//  Created by Minki on 04/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class PhraseMessageSet: Object {
    @objc dynamic var worshipOrderID: String = ""
    let phraseMessageList = List<PhraseMessage>()
    
    convenience init(orderID: Int, worshipID: String, phraseList: JSON) {
        self.init()
        
        self.worshipOrderID = "\(worshipID)_\(orderID)"
        
        if let data = phraseList.array {
            for phraseMessageJSON in data {
                let phraseMessage = PhraseMessage(withJSON: phraseMessageJSON, worshipOrderID: self.worshipOrderID)
                self.phraseMessageList.append(phraseMessage)
            }
        }
    }
    
    override static func primaryKey() -> String? {
        return Name.worshipOrderID
    }
}

extension PhraseMessageSet {
    struct Name {
        static let worshipOrderID = "worshipOrderID"
        static let worshipID = "worshipID"
    }
}
