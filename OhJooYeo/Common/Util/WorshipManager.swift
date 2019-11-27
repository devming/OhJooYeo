//
//  WorshipManager.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/09.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

class WorshipManager {
    static let shared = WorshipManager()
    
    /// worship-list API호출하고나서 바로 할당해 줘야함.
    var currentWorshipInfo: WorshipInfoRequest?
//    var date: String = ""
    var date: String = ""
//    var currentWorshipId: String = ""
    var churchId = 0 /// - TODO: [2019-11-22] 원래 0으로 해놓고 0이면 에러나게 해야함
    
    /// currentWorshipId를 할당해주는 메소드 - 'worship-list' API에서 호출해야함.
    func setCurrentWorshipId(worshipIdList: [WorshipIdDate]) {
        if worshipIdList.count == 0 { return }
        var list = worshipIdList
        list.sort { $0.worshipId > $1.worshipId } /// 날짜 내림차순 정렬
        if let item = list.first { /// 가장 처음이니까 최신 날짜 주보
            self.currentWorshipInfo = WorshipInfoRequest(churchId: churchId, worshipId: item.worshipId)
//            self.currentWorshipId = list.first!.worshipId
            self.date = item.date
            self.churchId = 1
        }
    }
}
