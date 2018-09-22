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
    var worshipMO: WorshipMO?   // weak 로 선언하면 데이터가 사라짐.. 메모리 해제로 인해
    var worshipOrderMO: [WorshipOrderMO]?
    
    var dateInfo: String?
    
    private init() {}
    
    func setWorship(worship: Model.Worship, id: String) {
        /// TODO: version에 따라 데이터를 저장할지 안할지 분기
        
        let currentLocalVersion = GlobalState.shared.version
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)]
        let currentLocalAdvertisementVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 1)]
        let currentLocalMusicVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 2)]
        
        let currentWorshipInfo = DbManager.shared.getRecentWorship()
        
        if currentLocalWorshipVersion == ConstantString.notSetVersion { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
            DbManager.shared.addWorship(mainPresenter: worship.mainPresenter, worshipOrder: worship.worshipOrders, nextPresenter: worship.nextPresenter, version: worship.currentVersion, worshipDate: worship.worshipDate, worshipId: id)
        } else if currentLocalWorshipVersion < worship.worshipVersion[worship.worshipVersion.startIndex] { // 받아온 Worship 정보가 더 최신일 경우 - Update
            if let currentWorshipInfo = currentWorshipInfo {
                DbManager.shared.updateWorship(worshipObject: currentWorshipInfo, mainPresenter: worship.mainPresenter, worshipOrder: worship.worshipOrders, nextPresenter: worship.nextPresenter, version: worship.currentVersion, worshipDate: worship.worshipDate, worshipId: id)
            }
            print("Update 수행")
        } // else 인 경우는 최신 버전으로 동기화 되어 있는 경우
        
        if currentLocalAdvertisementVersion == ConstantString.notSetVersion
            || currentLocalAdvertisementVersion < worship.advertisementVersion[worship.advertisementVersion.startIndex] {
            
        }
        
        if currentLocalMusicVersion == ConstantString.notSetVersion
            || currentLocalMusicVersion < worship.musicVersion[worship.musicVersion.startIndex] {
            
        }
        
        GlobalState.shared.version = worship.currentVersion // 로컬을 원격 버전으로 교체
        self.worshipMO = DbManager.shared.getRecentWorship()
        
        guard let date = self.worshipMO?.worshipDate else {
            return
        }
        self.dateInfo = showDateData(worshipDate: date)
        
        self.worshipOrderMO = DbManager.shared.getWorshipOrderList(worshipMO: self.worshipMO)
        
        NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
    }
}

extension WorshipCellData {
    
    func showDateData(worshipDate: String) -> String {
        let dateComponentString = worshipDate.split(separator: "-")
        var components = DateComponents()
        components.year = Int(dateComponentString[dateComponentString.index(0, offsetBy: 0)])
        components.month = Int(dateComponentString[dateComponentString.index(1, offsetBy: 0)])
        components.day = Int(dateComponentString[dateComponentString.index(2, offsetBy: 0)])
        
        guard let year = components.year, let month = components.month, let day = components.day else {
            return "\(worshipDate)"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko-KR")
        guard let date = formatter.date(from: worshipDate) else {
            return "\(worshipDate)"
        }
        
        return "제 \(year-1982)권 제 \(formatter.calendar.component(.weekOfYear, from: date))호 \(year)년 \(month)월 \(day)일"
    }
}
