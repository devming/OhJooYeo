//
//  WorshipCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa

final class WorshipMainInfoViewModel: ViewModel {
    
    private let worshipInfoSubject = PublishSubject<WorshipMainInfo>()
    var worshipInfoObservable: Observable<WorshipMainInfo> {
        get { return worshipInfoSubject.asObservable() }
    }
    var worshipInfo: WorshipMainInfo?
    
    override init() {
        super.init()
    }
    
    func callApi(worshipId: String) -> Observable<WorshipMainInfo> {
        
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId,
                                  WorshipInfoRequest.CodingKeys.worshipId.rawValue: worshipId,
                                  WorshipInfoRequest.CodingKeys.version.rawValue: WorshipManager.shared.currentWorshipInfo?.version as Any]
        
        return APIService.postWorshipInfo(parameters: params)
            .map { try JSONDecoder().decode(WorshipMainInfo.self, from: $0) }
            .do(onNext: { (worshipInfo) in
                self.worshipInfo = worshipInfo
            })
    }
    
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
        
        return "제 \(year-1982)권 \(formatter.calendar.component(.weekOfYear, from: date))호 \(year)년 \(month)월 \(day)일"
    }
}
