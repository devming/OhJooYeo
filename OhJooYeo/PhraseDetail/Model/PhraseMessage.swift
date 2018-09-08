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
        var phraseMessage: String
        var order: Int
        
        init?(json: JSON) {
            if let phraseKey = json[Name.phraseKey].string {
                self.phraseKey = phraseKey
            } else {
                return nil
            }
            
            if let phraseMessage = json[Name.phraseMessage].string {
                self.phraseMessage = phraseMessage
            } else {
                return nil
            }
            
            if let order = json[Name.order].int {
                self.order = order
            } else {
                return nil
            }
        }
    }
}

extension Model.PhraseMessage {
    struct Name {
        static let phraseKey = "phraseKey"
        static let phraseMessage = "phraseMessage"
        static let order = "order"
    }
}
