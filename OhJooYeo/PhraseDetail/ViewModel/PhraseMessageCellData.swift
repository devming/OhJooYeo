//
//  PhraseMessageCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 22..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

final class PhraseMessageCellData {
    static var shared = PhraseMessageCellData()
    var phraseMessages: [PhraseMessageMO]?
    
    func setPhraseMessages(phraseMessageModels: [Model.PhraseMessage]) {
        guard let worshipMO = WorshipCellData.shared.worshipMO else {
            return
        }
        guard var remoteWorshipVersion = worshipMO.version?.first else {
            return
        }
        
        let currentLocalVersion = GlobalState.shared.version
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)]
//        remoteWorshipVersion = "d"
        if currentLocalWorshipVersion == ConstantString.notSetVersion { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
            DbManager.shared.addPhraseMessages(messages: phraseMessageModels, worshipMO: worshipMO)
        } else if currentLocalWorshipVersion < remoteWorshipVersion { // 받아온 정보가 더 최신일 경우 - Update
            DbManager.shared.updatePhraseMessages(messages: phraseMessageModels, worshipMO: worshipMO)
        }
        
        
        if let version = worshipMO.version {
            GlobalState.shared.version = version  // 로컬을 원격 버전으로 교체
        }
        
        self.phraseMessages = DbManager.shared.getPhraseList(worshipId: worshipMO.worshipId)
        
        NotificationCenter.default.post(name: .PhraseMessageDidUpdated, object: nil)
    }
}
