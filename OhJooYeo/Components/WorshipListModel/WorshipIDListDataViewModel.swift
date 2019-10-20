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
    
    func callApi() -> Observable<[WorshipIdDate]> {
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        
        return APIService.postWorshipList(parameters: params)
            .map { try JSONDecoder().decode([WorshipIdDate].self, from: $0) }
            .map { worshipIdDate in
                self.worshipIdDateList = worshipIdDate
                return worshipIdDate
            }
    }
    
}
