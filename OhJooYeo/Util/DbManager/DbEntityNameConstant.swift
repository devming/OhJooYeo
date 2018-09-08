//
//  DbEntityNameConstant.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 15..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

extension DbManager {
    struct EntityName {
        static let worshipEntityName = "Worship"
        static let worshipOrderEntityName = "WorshipOrder"
        static let phraseMessageEntityName = "PhraseMessage"
        static let praiseEntityName = "Praise"
        static let advertisementEntityName = "Advertisement"
    }
    struct ColumnKey {
        struct Worship {
            static let mainPresenter = "mainPresenter"
            static let nextOffer = "nextOffer"
            static let nextPrayer = "nextPrayer"
            static let nextPresenter = "nextPresenter"
            static let version = "version"
            static let worshipDate = "worshipDate"
            static let worshipId = "worshipId"
        }
        
        struct WorshipOrder {
            static let title = "title"
            static let detail = "detail"
            static let presenter = "presenter"
            static let order = "order"
        }
        
        struct PhraseMessage {
            static let phraseKey = "phrase"
            static let phraseMessage = "content"
            static let phraseOrder = "order"
        }
    }
}
