//
//  PhraseMessage.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 27..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class PhraseMessage: Object {
    @objc dynamic var phraseKey: String = ""
    @objc dynamic var contents: String = ""
    @objc dynamic var orderID: Int = -1
    @objc dynamic var worshipId: String = ""
    
    convenience required init(withJSON json: JSON) {
        self.init()
        
        if let phraseKey = json[Name.phraseKey].string {
            self.phraseKey = phraseKey
        }
        if let contents = json[Name.contents].string {
            self.contents = contents
        }
        if let orderID = json[Name.orderID].int {
            self.orderID = orderID
        }
        if let worshipId = json[Name.worshipId].string {
            self.worshipId = worshipId
        }
        
    }
    
//    init?(json: JSON) {
//        if let phraseKey = json[Name.phraseKey].string {
//            self.phraseKey = phraseKey
//        } else {
//            return nil
//        }
//
//        if let phraseMessage = json[Name.content].string {
//            self.content = phraseMessage
//        } else {
//            return nil
//        }
//    }
}

extension PhraseMessage {
    struct Name {
        static let phraseKey = "phrase"
        static let contents = "contents"
        static let orderID = "orderId"
        static let shortCut = "shortCut"
        static let worshipId = "worshipId"
    }
}
