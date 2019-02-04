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
    @objc dynamic var orderID: Int = -1
    @objc dynamic var worshipID: String = ""
    let phraseMessageList = List<PhraseMessage>()
    
    convenience init(orderID: Int, worshipID: String, phraseList: JSON) {
        self.init()
        
        self.orderID = orderID
        self.worshipID = worshipID
        
        if let data = phraseList.array {
            for phraseMessageJSON in data {
                let phraseMessage = PhraseMessage(withJSON: phraseMessageJSON)
                self.phraseMessageList.append(phraseMessage)
            }
        }
    }
}

extension PhraseMessageSet {
    struct Name {
        static let orderID = "orderID"
        static let worshipID = "worshipID"
    }
}
