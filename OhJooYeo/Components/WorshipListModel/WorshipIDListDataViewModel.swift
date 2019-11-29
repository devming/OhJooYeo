//
//  WorshipIdListData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import RxSwift
import Alamofire

final class WorshipIDListDataViewModel: ViewModel {
    
    var worshipIdDateList: [WorshipIdDate]?
    
    override init() {
        super.init()
    }
    
    /// callApi
    func requestWorshipList() -> Observable<[WorshipIdDate]> {
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        print("worship list churchid: \(WorshipManager.shared.churchId)")
        
        return APIService.postWorshipList(parameters: params)
            .map {
                try JSONDecoder().decode([WorshipIdDate].self, from: $0)
            }
            .do(onNext: { [weak self] worshipIdDate in
                self?.worshipIdDateList = worshipIdDate
            })
    }
    
}
