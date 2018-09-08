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
    var worshipMO: WorshipMO?
    var worshipOrderMO: [WorshipOrderMO]?
    var orderList: [Model.WorshipOrder]?
    var nextPresenters: Model.Worship.NextPresenter?
    
    var dateInfo: String?
    
    private init() {}
    
    func setWorship(_ worship: Model.Worship) {
        DbManager.shared.addWorship(mainPresenter: worship.mainPresenter, worshipOrder: worship.worshipOrders, nextPresenter: worship.nextPresenter)
        self.worshipMO = DbManager.shared.getRecentWorship()
        
        guard let date = self.worshipMO?.worshipDate else {
            return
        }
        self.dateInfo = showDateData(date: date)
        
//        guard let worshipOrders = self.worshipMO?.worshipOrders else {
//            return
//        }
        self.worshipOrderMO = DbManager.shared.getWorshipOrderList()
//        worshipOrders.setValue(<#T##value: Any?##Any?#>, forKey: DbManager.ColumnKey.WorshipOrder.order)
        
        /// TODO: Notification 등록하기. TableView 갱신을 위해
    }
}

extension WorshipCellData {
    func showDateData(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ko-KR")
        let date = Date()   // TODO: 예배 날짜로 바꿔야함
        guard let dateString = formatter.string(for: date) else {
            return ConstantString.definedStringNoValue
        }
        
        // TODO: 예배 날짜로 바꿔야함
        let weekOfYear = Calendar.current.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        
        // TODO: 36권을 호출해서 받아야함. - WorshipCellData > dateInfo
        return "제 \(36)권 제 \(weekOfYear)호 \(dateString)"
    }
}
