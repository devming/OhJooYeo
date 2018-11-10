//
//  PhraseMessage+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import CoreData

extension DbManager {
    func addPhraseMessages(messages: [Model.PhraseMessage], worshipMO: WorshipMO) {
        for message in messages {
            if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.phraseMessageEntityName, into: defaultContext) as? PhraseMessageMO {
//                newPhrase.orderId = message.orderId
                newPhrase.phraseKey = message.phraseKey
                newPhrase.content = message.content
                if let id = message.orderId {
                    newPhrase.orderId = Int32(id)
                }
                newPhrase.shortCut = message.shortCut
                newPhrase.worshipId = worshipMO.worshipId
                worshipMO.addToPhraseMessages(newPhrase)
                saveContext()
            }
        }
    }
    
    /// TODO: worshipMO.phraseMessage 이게 호출이 안되나? - 확인할것.
    func updatePhraseMessages(messages: [Model.PhraseMessage], worshipMO: WorshipMO) {
        if let phraseMessages = worshipMO.phraseMessages {
            for phraseMessage in phraseMessages {
                guard let item = phraseMessage as? PhraseMessageMO else {
                    continue
                }
                delete(item)
            }
            saveContext()
        }
        for message in messages {
            if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.phraseMessageEntityName, into: defaultContext) as? PhraseMessageMO {
                newPhrase.phraseKey = message.phraseKey
                newPhrase.content = message.content
                if let id = message.orderId {
                    newPhrase.orderId = Int32(id)
                }
                newPhrase.shortCut = message.shortCut
                newPhrase.worshipId = worshipMO.worshipId
                worshipMO.addToPhraseMessages(newPhrase)
                saveContext()
            }
        }
    }
    
    // 검색 조건, worshipId에 맞는 녀석들만 불러온다.
    func getPhraseList(worshipId: String?) -> [PhraseMessageMO] {
        // 1. NSFetchRequest
        let request = NSFetchRequest<PhraseMessageMO>(entityName: DbManager.EntityName.phraseMessageEntityName)
        
        if let worshipId = worshipId {
            let predicate = NSPredicate(format: "worshipId == %@", worshipId)
            request.predicate = predicate
        }
        if let result = try? defaultContext.fetch(request) {
            return result
        }
        return [PhraseMessageMO]()
    }
}
