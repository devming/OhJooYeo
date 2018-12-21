//
//  PhraseMessageCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 22..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

final class PhraseMessageViewModel {
    static var shared = PhraseMessageViewModel()
    var phraseMessages: [Int: [PhraseMessageMO]]?
//    var phraseMessages: (Int, [PhraseMessageMO])?
    
    private init() {
        self.phraseMessages = [:]
    }
    
    func setPhraseMessages(phraseMessageModelLists: [[Model.PhraseMessage]], worshipMO: WorshipMO?) {
        guard let worshipMO = worshipMO else {
            return
        }
        guard let remoteWorshipVersion = worshipMO.version?.first else {
            return
        }
        
        // 현재 로컬에 저장된 버전
        let currentLocalVersion = GlobalState.shared.localVersion
        // 현재 로컬에 저장된 Worship 버전
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)]
        
        if currentLocalWorshipVersion == ConstantString.notSetVersion { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
            DbManager.shared.addPhraseMessages(messageLists: phraseMessageModelLists, worshipMO: worshipMO)
        } else if currentLocalWorshipVersion < remoteWorshipVersion {   // 받아온 정보가 더 최신일 경우 - Update
            DbManager.shared.updatePhraseMessages(messageLists: phraseMessageModelLists, worshipMO: worshipMO)
        }
        
        for i in 0..<phraseMessageModelLists.count {
            guard let id = phraseMessageModelLists[i][0].orderId else {
                continue
            }
            /// TODO: orderId값 이렇게 말고 진짜 orderId 호출해야함
            getPhraseList(orderId: Int32(id))
        }
        NotificationCenter.default.post(name: .PhraseMessageDidUpdated, object: nil)
    }
    
    func getPhraseList(orderId: Int32) {
        guard let worshipMO = WorshipViewModel.shared.worshipMO else {
            return
        }
        
        let phraseList = DbManager.shared.getPhraseList(worshipId: worshipMO.worshipId, orderId: orderId)
        self.phraseMessages?[Int(orderId)] = phraseList
    }
}
