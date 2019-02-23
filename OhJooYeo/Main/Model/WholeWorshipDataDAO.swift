//
//  WorshipMainInfo+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WholeWorshipDataDAO {
    static let shared = WholeWorshipDataDAO()
    var worshipData: WholeWorshipData?
    var phraseMessageSetList: [PhraseMessageSet]?
    
    func initWorshipData(json: JSON, worshipID: String, completionHandler: (List<WorshipOrder>?) -> Void) {
        self.worshipData = nil
        self.worshipData = WholeWorshipData(json: json, worshipID: worshipID)
        guard let worshipData = self.worshipData else {
            return
        }
        try? DbManager.shared.realm?.write {
            DbManager.shared.realm?.add(worshipData, update: true)
        }
    
        completionHandler(worshipData.worshipMainInfo?.worshipOrders)
    }
    
    func initPhraseMessageListData(orderIDs: [Int], worshipID: String, json: JSON, completionHandler: (([PhraseMessageSet]?) -> Void)?) {
        self.phraseMessageSetList = nil
        guard let phraseJsonList = json.array else {
            return
        }
        self.phraseMessageSetList = [PhraseMessageSet]()
        var index = 0
        for data in phraseJsonList {
            let phraseMessageSet = PhraseMessageSet(orderID: orderIDs[index], worshipID: worshipID, phraseList: data)
            self.phraseMessageSetList?.append(phraseMessageSet)
            index += 1
        }
        if let phraseMessages = self.phraseMessageSetList {
            try? DbManager.shared.realm?.write {
                DbManager.shared.realm?.add(phraseMessages, update: true)
            }
            completionHandler?(self.phraseMessageSetList)
        }
    }
    
    func getResult(worshipID: String) -> Results<WholeWorshipData>? {
        return DbManager.shared.realm?.objects(WholeWorshipData.self).filter("\(WholeWorshipData.Name.worshipID) = '\(worshipID)'")
    }
    
    func getResultPhraseMessages(by worshipID: String) -> Results<PhraseMessageSet>? {
        return DbManager.shared.realm?.objects(PhraseMessageSet.self).filter("\(PhraseMessageSet.Name.worshipOrderID) BEGINSWITH '\(worshipID)'")
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        if let array = Array(self) as? [T] {
            return array
        }
        print("[WholeWorshipDataDAO - ResultExtension] toArray")
        return [T]()
    }
}
