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
    var phraseMessages: [Int: [PhraseMessageMO]]?
//    var phraseMessages: (Int, [PhraseMessageMO])?
    
    private init() {
        self.phraseMessages = [:]
    }
    
    func setPhraseMessages(phraseMessageModelLists: [[Model.PhraseMessage]]) {
        guard let worshipMO = WorshipCellData.shared.worshipMO else {
            return
        }
        guard let remoteWorshipVersion = worshipMO.version?.first else {
            return
        }
        
        // 현재 로컬에 저장된 버전
        let currentLocalVersion = GlobalState.shared.version
        // 현재 로컬에 저장된 Worship 버전
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)]
        
        if currentLocalWorshipVersion == ConstantString.notSetVersion { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
            DbManager.shared.addPhraseMessages(messageLists: phraseMessageModelLists, worshipMO: worshipMO)
        } else if currentLocalWorshipVersion < remoteWorshipVersion {   // 받아온 정보가 더 최신일 경우 - Update
//        } else {
            DbManager.shared.updatePhraseMessages(messageLists: phraseMessageModelLists, worshipMO: worshipMO)
        }
        
        if let version = worshipMO.version {
            let worshipVersion = version[version.index(version.startIndex, offsetBy: 0)]
            
            GlobalState.shared.version = "\(worshipVersion)" + "\(currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 1)])" + "\(currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 2)])"
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
        guard let worshipMO = WorshipCellData.shared.worshipMO else {
            return
        }
        
        let phraseList = DbManager.shared.getPhraseList(worshipId: worshipMO.worshipId, orderId: orderId)
        self.phraseMessages?[Int(orderId)] = phraseList
    }
    
    
}
