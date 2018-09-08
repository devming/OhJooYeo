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
        
        init(phraseKey: String, phraseMessage: String) {
            self.phraseKey = phraseKey
            self.phraseMessage = phraseMessage
        }
        
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
        }
    }
}

extension Model.PhraseMessage {
    struct Name {
        static let phraseKey = "phraseKey"
        static let phraseMessage = "phraseMessage"
    }
}
