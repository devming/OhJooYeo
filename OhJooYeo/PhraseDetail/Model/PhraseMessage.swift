//
//  PhraseMessage.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 27..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Model {
    struct PhraseMessage {
        var phraseKey: String
        var content: String
        var orderId: Int
        
        init?(json: JSON) {
            if let phraseKey = json[Name.phraseKey].string {
                self.phraseKey = phraseKey
            } else {
                return nil
            }
            
            if let phraseMessage = json[Name.content].string {
                self.content = phraseMessage
            } else {
                return nil
            }
            
            if let orderId = json[Name.orderId].int {
                self.orderId = orderId
            } else {
                return nil
            }
        }
    }
}

extension Model.PhraseMessage {
    struct Name {
        static let phraseKey = "phrase"
        static let content = "contents"
        static let orderId = "orderId"
    }
}
