//
//  PhraseMessageRequest.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/13.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

class PhraseMessageRequest: BaseRequest {
    
    var phraseRange: [String]?
    
    init(phraseRange: [String]) {
        self.phraseRange = phraseRange
    }
    
    enum CodingKeys: String, CodingKey {
        case phraseRange = "phraseRange"
    }
}
