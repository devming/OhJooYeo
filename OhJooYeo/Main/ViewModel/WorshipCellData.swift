//
//  WorshipCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

class WorshipCellData {
    
    let worshipInfo: Model.Worship?
    var orderList: [Model.WorshipOrder]?
    var nextPresenters: Model.Worship.NextPresenter?
    
    var dateInfo: String? {
        didSet {
            self.dateInfo = showDateData()
        }
    }
    
    init(worship: Model.Worship) {
        self.worshipInfo = worship
        
        self.dateInfo = ConstantString.definedStringNoValue
    }
}

extension WorshipCellData {
    func showDateData() -> String {
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
