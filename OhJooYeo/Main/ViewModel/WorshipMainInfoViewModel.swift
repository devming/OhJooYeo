//
//  WorshipCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

final class WorshipMainInfoViewModel {
    
    static var shared = WorshipMainInfoViewModel()
    var worshipDataObject: WholeWorshipDataDAO
    var dateInfo: String?
    
    private init() {
        self.worshipDataObject = WholeWorshipDataDAO.shared
    }
    
    func setDate() {
        guard let date = self.worshipDataObject.worshipData?.worshipDate else {
            return
        }
        self.dateInfo = showDateData(worshipDate: date)
    }
}

extension WorshipMainInfoViewModel {
    
    private func showDateData(worshipDate: String) -> String {
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
