//
//  PhraseMessage.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 27..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

struct PhraseMessage {
    var phraseKey: String?
    var phraseMessage: String?
    
    init(phraseKey: String?, phraseMessage: String?) {
        self.phraseKey = phraseKey
        self.phraseMessage = phraseMessage
    }
}

