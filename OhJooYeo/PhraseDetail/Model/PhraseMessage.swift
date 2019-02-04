//
//  PhraseMessage.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 27..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class PhraseMessage: Object {
    @objc dynamic var phraseKey: String = ""
    @objc dynamic var contents: String = ""
    
    convenience init(withJSON json: JSON) {
        self.init()
        
        if let phraseKey = json[Name.phraseKey].string {
            self.phraseKey = phraseKey
        }
        if let contents = json[Name.contents].string {
            self.contents = contents
        }
    }
}

extension PhraseMessage {
    struct Name {
        static let phraseKey = "phrase"
        static let contents = "contents"
    }
}
