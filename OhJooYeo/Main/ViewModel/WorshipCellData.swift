//
//  WorshipCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

class WorshipCellData {
    
    static var shared = WorshipCellData()
//    var worship: Model.Worship?
    weak var worshipMO: WorshipMO?
    var worshipOrderMO: [WorshipOrderMO]?
//    var orderList: [Model.WorshipOrder]?
//    var nextPresenters: Model.Worship.NextPresenter?
    
    var dateInfo: String?
    
    private init() {}
    
    func setWorship(worship: Model.Worship, id: String) {
        /// TODO: version에 따라 데이터를 저장할지 안할지 분기
        
        let currentLocalVersion = GlobalState.shared.version
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)]
        let currentLocalAdvertisementVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 1)]
        let currentLocalMusicVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 2)]
        
        if currentLocalWorshipVersion == ConstantString.notSetVersion || currentLocalWorshipVersion < worship.worshipVersion[worship.worshipVersion.startIndex] { // 받아온 Worship 정보가 더 최신일 경우
            DbManager.shared.addWorship(mainPresenter: worship.mainPresenter, worshipOrder: worship.worshipOrders, nextPresenter: worship.nextPresenter, version: worship.currentVersion, worshipDate: worship.worshipDate, worshipId: id)
        }
        
        if currentLocalAdvertisementVersion == ConstantString.notSetVersion
            || currentLocalAdvertisementVersion < worship.advertisementVersion[worship.advertisementVersion.startIndex] {
            
        }
        
        if currentLocalMusicVersion == ConstantString.notSetVersion
            || currentLocalMusicVersion < worship.musicVersion[worship.musicVersion.startIndex] {
            
        }
        
        self.worshipMO = DbManager.shared.getRecentWorship()
        
        guard let date = self.worshipMO?.worshipDate else {
            return
        }
        self.dateInfo = showDateData(worshipDate: date)
        
//        guard let worshipOrders = self.worshipMO?.worshipOrders else {
//            return
//        }
        self.worshipOrderMO = DbManager.shared.getWorshipOrderList(worshipMO: self.worshipMO)
//        worshipOrders.setValue(<#T##value: Any?##Any?#>, forKey: DbManager.ColumnKey.WorshipOrder.order)
        
        NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
    }
}

extension WorshipCellData {
    
    func showDateData(worshipDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ko-KR")
        guard let date = formatter.date(from: worshipDate) else { //TODO: 이게 변경이 안됨
            return "\(Date())"
        }
        return "제 \(formatter.calendar.component(.year, from: Date.init(timeIntervalSinceNow: 0))-1982)권 제 \(formatter.calendar.component(.weekOfYear, from: date))호 \(date)"
    }
}
