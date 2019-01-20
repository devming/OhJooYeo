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
    var worshipMainInfoResults: Results<WorshipMainInfo>?   // weak 로 선언하면 데이터가 사라짐.. 메모리 해제로 인해
    var worshipOrderDataResults: Results<WorshipOrder>?
    var phraseMessage: [PhraseMessage]?
    
    var worshipDataObject: WorshipDataDAO
    var worshipOrder: List<WorshipOrder>?
    var phraseMessageShortCut: [String]
    var phraseMessageOrderIds: [Int32]
    
    var dateInfo: String?
    
    private init() {
        self.phraseMessageShortCut = [String]()
        self.phraseMessageOrderIds = [Int32]()
        self.worshipDataObject = WorshipDataDAO.shared
    }
    
    func setWorship() {
        guard let date = self.worshipDataObject.worshipData?.worshipDate else {
            return
        }
        self.dateInfo = showDateData(worshipDate: date)
        
        //        if let worshipOrders = WorshipDataDAO.shared.worshipData?.worshipMainInfo?.worshipOrders {
        //            self.worshipOrder = worshipOrders
        //        }
    }
    
//    func setWorship() {
//        self.worshipMainInfoResults = WorshipDAO.shared.getResult()
//        self.worshipOrderDataResults = WorshipOrderDAO.shared.getResult()
//    }
    
//    func setWorship(handler: @escaping ((WorshipMO?) -> Void)) {
//        /// TODO
//        /// 고려사항1: 예배 날짜가 바뀌면 버전이 초기화 되어야함.
//        /// 고려사항2: 날짜를 history에서 바꾼것이라면 초기화가 아니라 기존의 버전정보를 불러와야함.
//        /// -> parameter로 불러와야할듯.
//        self.worshipDataResults = WorshipDAO.shared.getResult()
//        self.worshipOrderDataResults = WorshipOrderDAO.shared.getResult()
//
//        guard let date = self.worshipMO?.worshipDate else {
//            return
//        }
//        self.dateInfo = showDateData(worshipDate: date)
//
//        handler(self.worshipMO)
//    }
    
}

extension WorshipMainInfoViewModel {
    
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
